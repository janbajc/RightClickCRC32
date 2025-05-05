param([string]$Path)

# Clean up and validate the input path
$Path = $Path.Trim('"').Trim()

# Add GUI messagebox support
Add-Type -AssemblyName System.Windows.Forms

if ([string]::IsNullOrWhiteSpace($Path)) {
    [System.Windows.Forms.MessageBox]::Show("No path received.", "CRC32 Error", 'OK', 'Error')
    exit
}

if (-not (Test-Path -LiteralPath $Path)) {
    [System.Windows.Forms.MessageBox]::Show("File not found:`n$Path", "CRC32 Error", 'OK', 'Error')
    exit
}

# Add the CRC32 hash algorithm class
Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Security.Cryptography;

public class Crc32 : HashAlgorithm
{
    public const uint DefaultPolynomial = 0xedb88320u;
    public const uint DefaultSeed = 0xffffffffu;

    private static uint[] defaultTable;

    private readonly uint seed;
    private readonly uint[] table;
    private uint hash;

    public Crc32() : this(DefaultPolynomial, DefaultSeed) { }

    public Crc32(uint polynomial, uint seed)
    {
        table = InitializeTable(polynomial);
        this.seed = this.hash = seed;
    }

    public override void Initialize()
    {
        hash = seed;
    }

    protected override void HashCore(byte[] buffer, int start, int length)
    {
        for (int i = start; i < start + length; i++)
        {
            unchecked
            {
                hash = (hash >> 8) ^ table[buffer[i] ^ hash & 0xff];
            }
        }
    }

    protected override byte[] HashFinal()
    {
        var hashBuffer = BitConverter.GetBytes(~hash);
        Array.Reverse(hashBuffer);
        return hashBuffer;
    }

    public override int HashSize { get { return 32; } }

    private static uint[] InitializeTable(uint polynomial)
    {
        if (defaultTable != null && polynomial == DefaultPolynomial)
            return defaultTable;

        var createTable = new uint[256];
        for (int i = 0; i < 256; i++)
        {
            uint entry = (uint)i;
            for (int j = 0; j < 8; j++)
                entry = (entry >> 1) ^ (polynomial & ~((entry & 1) - 1));
            createTable[i] = entry;
        }

        if (polynomial == DefaultPolynomial)
            defaultTable = createTable;

        return createTable;
    }

    public static uint Compute(string filePath)
    {
        using (var stream = File.OpenRead(filePath))
        using (var crc32 = new Crc32())
        {
            byte[] hash = crc32.ComputeHash(stream);
            Array.Reverse(hash);
            return BitConverter.ToUInt32(hash, 0);
        }
    }
}
"@

try {
    $crc32 = [Crc32]::Compute($Path)
    $formatted = "{0:X8}" -f $crc32
    Set-Clipboard $formatted

    # Extract file details
    $directory = [System.IO.Path]::GetDirectoryName($Path)
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $extension = [System.IO.Path]::GetExtension($Path)

    # New file name with CRC appended
    $newFileName = "$filename`_$formatted$extension"
    $newPath = Join-Path $directory $newFileName

    # Check if new path already exists
    if (-not (Test-Path -LiteralPath $newPath)) {
        Rename-Item -LiteralPath $Path -NewName $newFileName
    } else {
        [System.Windows.Forms.MessageBox]::Show("CRC32: $formatted`nBut could not rename:`n$newFileName already exists.`n(copied to clipboard)", "CRC32 Hash", 'OK', 'Warning')
    }
} catch {
    [System.Windows.Forms.MessageBox]::Show("Error: " + $_.Exception.Message, "CRC32 Error", 'OK', 'Error')
}
