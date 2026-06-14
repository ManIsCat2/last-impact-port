import hashlib
import glob

def main():
    bin = glob.glob("cutscenes/*.bin")
    
    with open("cutscenes/hashes.txt", "a") as out:
        for path in bin:
            try:
                with open(path, "rb") as f:
                    data = f.read()
                hash = hashlib.sha256(data).hexdigest()
                
                out.write(hash + "\n")
                print(f"{path} -> {hash}")
            except Exception as e:
                print(f"Error processing {path}: {e}")

if __name__ == "__main__":
    main()