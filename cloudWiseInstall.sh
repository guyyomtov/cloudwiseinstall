

# Create a directory named "cloudwise" if it doesn't exist
mkdir -p cloudwise;

# Define Node Exporter URL and file name
NODE_EXPORTER_URL="https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz";
NODE_EXPORTER_FILE="node_exporter-1.6.1.linux-amd64.tar.gz";

# Define Process Exporter URL and file name
PROCESS_EXPORTER_URL="https://github.com/ncabatoff/process-exporter/releases/download/v0.7.10/process-exporter-0.7.10.linux-amd64.tar.gz";
PROCESS_EXPORTER_FILE="process-exporter-0.7.10.linux-amd64.tar.gz";

# Define the content to append to process.yaml


# Navigate to the "cloudwise" directory
cd cloudwise;

# Download Node Exporter
wget "$NODE_EXPORTER_URL";

# Extract Node Exporter
tar xvfz "$NODE_EXPORTER_FILE";

# Navigate to the extracted Node Exporter directory
cd "${NODE_EXPORTER_FILE%.tar.gz}";

# Run Node Exporter in the background
nohup ./node_exporter &

# Go back to the "cloudwise" directory
cd ..;

# Download Process Exporter
wget "$PROCESS_EXPORTER_URL";

# Extract Process Exporter
tar xvfz "$PROCESS_EXPORTER_FILE";

# Navigate to the extracted Process Exporter directory
cd "${PROCESS_EXPORTER_FILE%.tar.gz}";

# Append content to process.yaml
echo "process_names:" >> process.yaml;
echo "  - name: \"{{.Comm}}"\" >> process.yaml;
echo "    cmdline:" >> process.yaml;
echo "    - '.+'" >> process.yaml;


# Run Process Exporter with the specified configuration file
nohup ./process-exporter -config.path=process.yaml &

cd ..;
cd ..;
