(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� {�%Y �[o�0�yx�@B(�21��K�AI`�S��&�Ҳ��}v� !a]�j�$�$r9�o���c��"M;�� B��������u�]���w�$IBM�DQ�:��k���?�2I[�ZL�G�u���SRD"�2�w�g")�Q$��!oE}$�� س�H�m����5"�{kE���)��zf��Z���	J1z�F����� h�ƥpѕ٥�ِ�b���h
��Pӵ�������Z��~L��h�z��ȹh�=��b"o�V`�
��Md6�h�0[�h��M��J���9��9�4�냅�����a�{�rJ1�����O|�$����"m��m'�έ�ފ�u<��Ʀ�P���b\��ɨO�W����V`���*�jxBo�U��6B�Å61���P%�TE��Q���������.�t�[��L�b�!��n�ua�M4"�\|�ˀ8�C&~�4p�f�*�|���s����_�f�Z�5	ߩl�+�J�٥Q��|��[��Cu:WuZš:���e�i� ���	���>�cz��Ip�]�傂j6��-y�Ϸ<D�����A�Mp�>����Ā�lH�n/���p7s����K���d��&��>���>�6A�
�ܨ<�.��Cv�)l�5	m����<��v̱��E)��6YUꥪ��n��b���Y�%A(���� *H�so�煺��[���B~Mȣ�]|�>��鯞����*���p8���p8���p8���p8��B!9� (  