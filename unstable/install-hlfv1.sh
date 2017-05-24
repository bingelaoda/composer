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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� {�%Y �][s���g~�u^��'�~���:�MQAAD�ԩw� �����&�\&��Iسk��&��izu�o����M�&�r�U0�/�$M���I���_PEQ�Q��7���9�y�m���Z��&�w���r���C�>���I7	���ho��*��q��)�*���������@�X�B`X%�2�f�7�T��%	���P�w���+���p��	�������?��&J�W���'i���_��k�?�hv���'=�0Ew�~z��=�h, (��/��'����D��g�^����c�?��.��.�y��S6�6J�4JS�C6�,BQ>B:>���`��x�(��M�Yc���Q��O�"^��8�>��x�M~�!et����
pbCVk"/�A���&0�Z[�Ny��ty���,#�>��&��?X�z��Z��P6i-hS���Zu�)�D j����W�،���@O+6�	=�;�|<7�C�����MZz2?�	K����ԍp?��A"�D��v���8�uY����/m��W_�k߾A�Ɗ���k�������-�+�O6?w/��(����J�G��.���:�����G	{��q��������Eݐ%�����e�i�<p�!�d����$>���3�x�\���2@���d>��4M 3.T�4�x�LMk�Y�EC�Ё�sJ[ä��w-C*�v����:���,��5$g�H�9GQW s��D�݆�p��a|��z\��P��-ƣV�]�{�#F�`��"(�R\����H0�<M>�����Ď��L�4��x:t�94��:q������P�K308繆`�yS��.���-��ܷ
�@��Y��	٩_1�d�y0��J1���)�p�M�'
�N��
p���KBi���خ/���D&�݈���`w�Ɗ�Q+U���_uЦ�6��0�X�%C�w#�w��f��9�Zݙ�M]������ �xO�D�4�y<�S4�y����zqn���L�.D�#]��EY�.R&�-���N�y\32[�GFѦI��[��(�7͵��d�E�$�8�e�G �C�Gr��"��`�E��,���~��#�e�};�Cn5IZRML�G]}Ȥ1�,�#9�h�,z�4e����������gf9�%��N�7��{��*�/$�G�Om�W�}��Xq�������,�gy��:PC��f{���x�#��'�3>��v4��3� ��B?b�K����P�I�W��b~U0U��<-�~pPf�}�"�{�Z�XX���+$�MY�b����=8��DѭL������5$B}՚8K5v1uw����~o�Y4]>(�<3�y�i��}߁��{o��]~�-C��e[�*�	ቪ{@k��ͶpHA�-MSΌ�6 �$.˳@���y����*�q������xH�8�t�=܇�.���|K3ymJ
�(�Hs=4���Lrآ��Fޥ>��6s4!��7�8��D���͛X�����P���o�m��D����0��Z<��h�Y�!���&��x��_�������H���("��9�_���#�T�_*����+��ϵ~A��9&�r��=B���2�K�������+U�O�����):�I#������8E���!h��Ew�e
���E� �h��H�����P��_��~�C�t������vO�M
ZY8�XOPWiǳ�>�{�qta��U���?�؁]�
f�dܐ㦩�;&[y��2���!r\o}�1�>��:ٍ,� ��ܘ�����ߴ[P�	�ەlO�*��������?U�)�(�x�Q��2P��U���_���.����?�����������r����=��f�/��#��f�9/���0�`��ˇ�f	���M���� ���&s�;P�L��#�.�CL<����ܚ�=��#�a�|�PK�1�k�07C����ݲ�L�[��e�G�)Q-�q>AW:ܠ�ɺaEx�h]c
���lPD$���@v���,�A���)�8�@r��%�i�V��ڙN�m�|��5Y���.,����μ����´gOM��@�$0����;����C��<,��$d�ݦ��v�uV�LiYZw4�C^nvL5QBڱ�����Y���$d��9�����O�K��3�Ȋ����������KA��W����������k�����E���K�%���_���_�U�_
*������?����?�zl h��T�e����t���GC�'��]����p�����Q�a	�DX�qX$@H�Ei�$)�����P��/��Ch��2pA��ʄ]�_�תbyñ9�5�f[{�9Һ�l�G�p��Rx1�%��fQ�N+	54$w��M"{���#�D��3vJ������nO@�� ��l�q��g��R2j��U�����%��|����(MT���������S�߱�CU����{�R�\�8AU��W�oo_V�˟�1���H����b���t�����?�ԟ������2�)�:w�Y�X�ql�t�b)��(�s	��l<!p�u<�Y�	ǷY���j��4�!���p�8��Z��|\���Et|KD�X�Ř���6�,�3�)��D�l����z@.�j�uw�9��+>��z"�F����L8�u~�zͥ|�G�|F�D��Nc�;����&���k��3[��ލ���/m}��G���W
~�%�������W>i�?Ⱦ4Z�B�(C������M�:�����k�_�"��㿟��9k9
�V�% �<4�g�?�g}��$�����{7����*-û����]�wi�����|t�zt4tw�{ρ�4���i疉��O}�J'�y�Jw�m�=b��7��j�6�a�ŰE�\�n&i}�G"<c8x&�8�d6ub�ysD������w⢹���lЌU0�9����#=�mE(����1��&1`[���&�0�BK,�p�wk�ʹ���hMX���UjS����ʝJ���9�Za��5�� �RgD��ޖK�d�w��n7�5���`��Ԝ��}]q��B[K�u��8�8g��vv���" ��P�8�+��t���I4�[�3ۧ�+k]ׇ��9^(i��Ń}��i;�;����R�[��^��>g�� �r~K�!�W��g�?�����/o��ѿ��1n;l6x7���i*�;>��������2?yf(?��G�t���@�O��@�q[z-PS �]��'n��k��<�������nBJ�Hڡ��';����]�5����Ԅh�{ķf*�n�	C:�Θ8u�Z�������n$���q_���==���A��}�R{���Țe���	ԥhm7�g�.��&}{��i#^ϥ.���d&���j�l��;�z�׷|��N�aFHt�*�!9n=����O����� .���"���K�oa����?��?%�3�����A����������������j��Z����)0��X����K���ܺ���1
!���RP��������[��P�������J���Ox�M���(�8�.C�F��O�L�8��C�O��#��b��`xu
�o�2�������_H�Z�)��J˔l9>Z�Ԍ`��"4����V�Xd�l�-Z����?�`9�������7�{�����0�C���+7���C�;WpD��޷t����MN0���Je�iͪ�?��s?���2�R���\|�3~>��|�?=��@����J��O�\�����A��즮�~�j5�F�K�6]ڡ��69�~��0����$S�ʵ���"��k�����>}�_��I�Z��͹�Z��&N���4����7.��Z��v���q�l��u��FH�k��_��|�.����NjWn���u�
�njWy�u�ZL~��'?9��Bǹ�����89�v��N,��~��_�+���h�]�����T��o}���^m���OnV�2�}sW���nG���w����b���.����4DU�A�#�Q�����7������ŵ/��hv�o�l_+*ɝ��sGm��&��$L�o_��Y�z���vy�Q�=Y��= ���҂�?o�2���+0:���o������H_~٢�-��D��i�ŽyX��.f�O�z�T���������n��A��^�}?{��|�%��rQi�a�����E�|�
o�i�G����L�4q�p��l��\e�`�=�ڽV{��D�:)!�#%pVϧ�� }T�#����Gd��S7�X=��^�E������	d��
�8��!�"v�7��@�Uő�m�l��ɦ���וU��v5��ax�xg'p�]�gK�:}8�O����ͧ���{��W�������w����u.���p9� �\�s����^:T���m���}Sr��v[���{'&�	1�ė�1|���"&�I�~Ш_�J !�C�(�D����ֳ�m���>7��k��K��������lr�rSn%d"v���D2A�")<]F;�Y#�L&���LG�a\��e혀��I��,/L��p:�ǭ��7�r`��ѱ��b 6t/��5 h��s�3�ۄ�J�ńq!v�E�Q�%I������v��k�&��u#��
�k�Cn��4�0�Rt�kq���3V3EL<�d�v[�t�ԵQ�w����|x�Y����P�����&3ّ鶐-$��[�'�%��*|��H�w�w�8g܄�e���_3�\We�ДF�#!2�R��8�.�F�j�5�w���Bi1^2f^�[��[7gyQc4E��)��F�E�E�e�6��Q�ti&Nm8=�����_�S�;��ɉ����4�b|�\]������iU��=�s�g�w�yN��S�9�uPK�!ˠ�Hҩ��#U��q���YG�S���=�Re�EXs�7#�ˈ�H���׌�����|t�D��8��U���.s�fGW���u�q�]d��SyV��R�6y����U�.r�\�lQ�I�Z;[3o u��j����g��d&/G��O�����g�uT�h��*�7V�x�s.���=��k�n���4m&?�t눅��8/��f��8��ˈ	���91�{�*���v.����7��Z��|WW�%�Ѕ����÷9Z���������3w��T��WU�1�p�i�捣�����#`>��&�m�߭:����F��f��������w?�W��!PX;�qj��?���Z*q�m����<�j@:H��ȶ�W�~ԍm{Y�^϶�Z���U�G8�rzF9�I�{����~�3����[���x�7�/?��K���s�+x���n<AA?s�kƁp�N��;؍�C/޹�s�*��sз�AO�����������}z��}O��)���7�׳�y`D��{Q�K�Y�G�c=:��%�I��9a�\/L�A��-��mf�7
�t��D�T��F�Hn��m�K��bg�Y��D?C�ݜ�����C�+��f�v�r/��|i����;]P�d�8̣X���'�9��-F�%��G��~��݂�0I��F���a�]��=L��~����юp�S��,>^$����YB�tv�W2��TQp�	�T����|��R^�+`XNU[BLHz.%5XHh[%U�)�͇���K�)Nz��R��C�\ڏ�=}�f��LX�	�
z�@��K티�M=u��6��D�����!\�kO͕�u��`�ck�tM�F�xP�*�'����&�e���G�~ee�h.O�B��j�Z�;J��0�m����D�!��$3�0i$]N�L�D�ɰX��'�9d�#<#;V0��x'�	���*�!VI�����.֊�x���|�&��4/^�@�0J��t}�3�r�t3��ۉx��R4���z��ǘȾ�h���>&eY�댲l�3����r)���TJÁߝhpp��$_�h��p�h8��mi�+�|+�Zb�
��b+-_�ʕ�A4���)�Ht^+JT�RU@�4�c�x�%��e����Re��<�+�ѴoHZ��ѭ+r���N$*g=�x�q�T���Z�yw�
�n!A�JFj~$�d��^��t�b	��U�[e�-R��e��,��%��z<C!�V�ˣ$���@HP� ACwR��fn��ya����^jX@�J�(o��ډa�\e�nu����@@N��,a1Y�b��E�@YIo�I�ҙ2� sʲGxFv��0�M�;�a|o�Uk}Z(�L�Y�W��K9o6�s�>t��7���#�}��rmB��<��g(F�I�-G�A��I;f?eq�>����>�j>��)��iN\SPkm^ՠ�@�֮�6�5�����g��_��L0>�.@]���<�Й�<�WNW���ʡ�ڸ\dۜh���N��\�����%r78C���9(%K5n ��n�9�Wڸ$�Nn�	n"F1�4��՚�UC�֦������-��e
�C��IM�dK�	�5[��y�f��X��琳?�n�iu�Y���U��^?a�\ 7
`��j���-������*��6Kf|bZf���=w��E�Q�Ϝ�^����釞�6]�ŉ�j|<� 't p�I_�?9Fֿ�:�G���ס�֡���g��/+�<~��=Zx0i-<H�HB�g*]�$�V������-<(��:"m����`8;4�E�A�΃�"Xu��Ҟ'�8ꂃ�V�Әn֔A�{b��0c	>nzh��;CjSj�W����R��2�p���%�!ъ#��P� 9��
�"Bpd�)�Ѽ��&�tR�J�zq�и�T���*u<F�	�=�#A!m��11���!�GM���c���ajt����D�;X�Uo%���r$ӈu����|~g�P�T�~e�m)�(�l؃�`����o�ol�m�v|��ń`KT�H
Q��k�f��I��[g���K5��K�xx_�p��a�m���]/�n�6ݩ�eʹ<m�Cc�d:��gZ1byv�@w肷Ne�:me��y'��@˽����ct�����a�/��eG�>8��U��Tp�m�$Rn�*�d�u���92P�x�#���*��r���A|&(2����E&����t��,�?=�.�f�!��T��Rv�b�J�`$�����8��
 LxG�p0%�e�	 ^V�$�i����e�;}_N�RBńp�0�����B�Bw;�l��aB�Ɩ�|;����JQ�u%
�6��J]��3�W,�mwD�Q�~�+�*x�����0₳L��٨f�A��lɅ���;<���-	�s.�n�$���\���&qW�^"�}�v^�ò��6��7�8��㞍��䔹���X!��RHn�0��Ep���m6�jb�%d�j�kwT3Z��=�0%�>�h╊�k��v�~��k����BqI��[���S�(����; �R��=G5��?���	�
�ͽ,f׫���ͭ�w|�_��KO=������_��е�~ ��U���5��N�i�D�c��@�'�ݻ������%���g����Ko��� �x���M|󦿾��W�? z�$��8x*�~p�ڕޯ��䊞n��h:Q�m@g߈��O~�/6~'����_/��׿�'��)�����4E�|�	�9K�|զv��N��i�l��M����߿��i; mS;mj�M��}6�g{?P;ͷ��|�� U�B����z��&�&�A�-"�N21����L��1��=��_��^��&��<ۭ�y��T�S��3���6���gp��X���`9_�MM�Y�i�sf�h�=gƞ`O�����a�e�3s���G�s9f�\8�0�!Bk��6�]��1�9��_ju��b��Nv������M�$�m  