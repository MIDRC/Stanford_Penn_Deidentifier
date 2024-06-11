# Use an official Python runtime as a parent image
FROM python:3.8

# Set the working directory in the container
WORKDIR /usr/src/app

# Download and install dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the GitHub repo
# RUN git clone https://github.com/MIDRC/Stanford_Penn_MIDRC_Deidentifier.git
RUN git clone --branch dockerize https://github.com/juliannicolas90/Stanford_Penn_MIDRC_Deidentifier.git


# Change directory to the cloned repo
WORKDIR /usr/src/app/Stanford_Penn_MIDRC_Deidentifier

# Install Python dependencies
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
RUN pip install -r requirements.txt

# Copy the conversion script and entrypoint script into the container
COPY convert_csv_to_npy.py /usr/src/app/Stanford_Penn_MIDRC_Deidentifier/convert_csv_to_npy.py
COPY create_outputs.py /usr/src/app/Stanford_Penn_MIDRC_Deidentifier/create_outputs.py
COPY entrypoint.sh /usr/src/app/Stanford_Penn_MIDRC_Deidentifier/entrypoint.sh

# Give execute permission to the entrypoint script
RUN chmod +x /usr/src/app/Stanford_Penn_MIDRC_Deidentifier/entrypoint.sh

# Run the script when the container launches
ENTRYPOINT ["./entrypoint.sh"]
