GDPC                p
                                                                         X   res://.godot/exported/133200997/export-1ab5dac2128a3e8bc06f45f85e03234a-zoom_game.scn    e      &      �9��j�����|`    T   res://.godot/exported/133200997/export-362256a061aa8890e9a1e558b11e5ec3-node_2d.scn �!      0      Ǳ�R<�\�X������    ,   res://.godot/global_script_class_cache.cfg  x      �       Ξy�ܒ��lT�:{�:a    D   res://.godot/imported/Car.png-fc15a8800134eeb93976b3828bce7a51.ctex 0      �      ��]ʋ���t#T�r�    H   res://.godot/imported/Untitled.png-30da513a925d9064453decddf41ecbd4.ctex�c      ^       ^��g��!�_[�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex       �      �̛�*$q�*�́     L   res://.godot/imported/parallax-00.png-f0768b4374230fb3719cdb96f926470f.ctex �$      x       �kB�\0��i�l��    L   res://.godot/imported/parallax-01.png-4d7fc7821602a4f752257e7f813722f0.ctex 0&      �      y1��7"�aA[!��    L   res://.godot/imported/parallax-02.png-dc9be51f46e2448ab77aa58c5651cd88.ctex �8      �      B��\2�pv�������    L   res://.godot/imported/parallax-03.png-e44cff5ca3054de95a4389d73dec0029.ctex  T      �      %�=7�9rZ6�H�2    L   res://.godot/imported/parallax-04.png-fbf8ff28803f8ee1f407d797b77fc18b.ctex �`      �       �K�y�ʏd�6UdЅ�    L   res://.godot/imported/parallax-05.png-b9a77a5afb762502c6c2d02e56149664.ctex  b      t       #�ؔ4!�w��#���       res://.godot/uid_cache.bin  `|      Y      +�	ݷ��k񲡇��       res://APM Count.gd          n       "jJ�n:�����1{�       res://APMCounter.gd p       �      �|!Դza�IL,��D�       res://Car.gd`      �      �����`�⏷�/�       res://Car.png.import      �       %Gl�\;¶�o�4�(�       res://Game.gd   �      "       P��,������~���       res://Score.gd  pc      \       䵋�%�� �f"����       res://Untitled.png.import   0d      �       6���8���b�E�9�       res://icon.svg  �x      �      C��=U���^Qu��U3       res://icon.svg.import   �       �       �h�S?	���f��&O�       res://node_2d.tscn.remap0w      d       s�OR��0*�FC       res://parallax-00.png.import`%      �       ����k����@�       res://parallax-01.png.import�7      �       �}�d�N�pw�@���J       res://parallax-02.png.importPS      �       �O�j|ϣ��d:       res://parallax-03.png.import�_      �       ��:��P��O��       res://parallax-04.png.importPa      �       엚A�q^Ğ�x�       res://parallax-05.png.import�b      �       ��#0�k���)�>ɚ�X       res://project.binary�}      �      ��GBR	>ؕ����H       res://zoom_game.tscn.remap  �w      f       �.fj���K�X����)    /�tu�J�=���extends Label

@export var apm: APMCounter

func _process(delta):
	text = "APM: %.2f" % apm.get_average_apm()
eMextends Node

class_name APMCounter

var timer = 0
var running = false
var actions: Array[float] = []

func start():
	running = true
	
func _process(delta):
	timer += delta
	
func add_action():
	actions.append(timer)
	
func get_apm(time: float = 5.0) -> float:
	var recent_items = actions.filter(func (x): return x >= (timer - time))
	var count = recent_items.size()
	return float(count) / time

func get_average_apm() -> float:
	return ((get_apm(10.0)/3) + (get_apm(5.0)/3) + get_apm(2.5) /3)
4`extends Node2D

@export var path: Path2D
@export var apm_target = 15
@export var apmCounter: APMCounter
@export var curve: Curve2D
@export var background: ParallaxBackground
@export var sprite: AnimatedSprite2D

signal score_updated(new_score)

var alternate = false
var key = "ui_left"
var started = false
var ended = false
var score = 0
var time_passed = 0
var game_length = 5

func _process(delta):
	if Input.is_action_just_pressed(key):
		if not started:
			apmCounter.start()
			started = true
			sprite.play()
		apmCounter.add_action()
		key = getNextKey()
		
	if started and not ended: 
		time_passed += delta
		var apm = apmCounter.get_average_apm()
		score += apm
		score_updated.emit(score)
		var t = clampf(apm / apm_target, 0, 1)
		var pos = path.curve.samplef(t)
		position = position.slerp(pos, 0.1)
		background.scroll_offset.x = -score
		sprite.speed_scale = apm
	
	if time_passed > game_length:
		ended = true
		position = position.slerp(path.curve.get_point_position(2), 0.1)
		
	if ended and Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		
func getNextKey():
	match key:
		"ui_left": return "ui_right"
		"ui_right": return "ui_left"

func _on_start_game():
	started = false
�'ri%GST2   8  |      ����               8|        �  RIFF�  WEBPVP8L�  /7�o`*���zE��S =�P�HR�{���
��L�*�$�)$x��.*�?Z �k	 � �	@}�{��ho�����mr#IL@�=��t��aA*ݪ��L�;%�s�Z���Y��ټr{oaNPu�����a&��F�Ԁ�-��eۍ��"�7� h7_P�����������?����?�k����J���|������f�������4%$o޼Y�z�n�4=$oV4=?r��o�7�������-��/t=�1��g��zvvg�g�뙵�]�gI|&�,t=��fr��}y~~V/=Q;���f������,�,t=3��Y�g1_w��g_
?�_�zfj����m�αh����+�����h'�T�<k��;A�3�X���J����!�|��3&>��v��,t=�����Γ�G^�����9���}|wN��R�Y�zfa��RI�<)מ�g?]����4'���@�v?�_�z�ۉ-�d�s�bٝW�gNv��Hy��w����*�vb��ʎ�G�b	�Y�z�cg�Y2p��XW�gFv��;O*�XB~�"=m�`d��ç��|���&p�N�$�<wM�my����k��_G휚I�R9t]�g�����E�>���M��$�������Ⳕ׊�w���5����|��;���.)�<EaI�׊��	/�מ��z���DO���g�S�|&x�Ld����f�s�C�D7��Y��b9��V���I�&G˳�"	��
=�lL~�C�)���;�x���61V
=��F��#��f�ӓA�f]�����eh�.�9΅����?~.��3�@�㇍�l=9m�=�c6�W�^=�OVA�u@O�>i^��y�z�4���g�����a"�r�٬ z�m�PN�ar~���gг�E�̉n���y��dHp>4�g�����x�<jr<���9�e�s�癲Sn��Ȱ,M;�˟����@�^�tS�@���K�ŧqn�W���#$5ՎLc��[L(b��g�~��M�H�eI!2�k��� �W��B��wE����C�/_ϘKO��­6�c�av�M����'Dp���r�˨V�=̠��㨨��z@��bz���9w3�nv���AEv=���U�yӢr��E��ad�c�EA�j�38���*���	�ۢć�9C�хc+����ò5��PP���Y�zz�m*�����*���4[o�XG�fq�A�iK���<_zB�h6�]z��zFG���Z������l���5[':`��`��]��A���%���z����P�����=a5�k�������l����u4�k�e��;��zz	��.=���C��K���YC�@�
�N���*��-���-��;b'�n6=�Cȑ��*=�qh�ýf��U�H4��p�2�����jUd׎��^��nq�urvk]zX�3 �Q��*���bzbYX�h�Q��r�9N�q '�T@ԋ���.����<\�ѥ��J.
��(r��*�>��zB�m��y�F�f�U4���<��7fT�@=z ��=
�*@���;�<U��^3V���-��6�l��d��[X�0���\zae���1��_�����jEU�͆~<��x��\4����ܫY����h9	'A�"YD���H `I��G�8b�$���à/��b�'���)Dx�dг��l�0�%�8�G���A��xB����dD�AO���÷"r��k	e�Hzg,k*1N7V��R �%m����RB�Ї5��6�ɪ���qJ#ۏq��=���1�i��ʤ�f�S�l���#�fE��������*�nf�|���=�J��L=�d�U$�l�C1�iU�iy=N�1��04�*�	���lN���⼂�����Ϲ�znEK�ɵ��$�R�-%��W�ЭGφ��PPO���S�P[a�l�nD�)��X�|��kݐ �yZ������Z0a��1V����� �`u<`\=��*F��{*���}�AQϾ��H�C:�l?��y���fY��*��C�t��y孩ٜA�y��'AL�y�ܨ���{�.Nt���p�RD�=� 7��4[�[EU�8`�씭b�=6eT �ۿ��� �t�
ڊqpx�A���l|,s�C���۸d�' 	"NBO�A���p��hj6b�@q=���0M����������^�$e�Dp�G
�;𷒆*Ɓ�E��',2���fs$��h6��@�5s�+�(��R�~�$1�5z4 ߽c���izrbH����W-̛q`�jKVQ�iXh]=z�#�G�1��k�7��q/�H�$��ͥgXIP�CϦ��8"�V�e��NLYuUL���Ƒa;�������:�qn$�(Ѓ�N�FxАZ^�"Ė�w�����U��z�*"�Q� �k���8��*M���+����kh6-��_P�8������._E��&�wQ�]�c�C�X��.������T���@#�!C��R7����x�w2uU��/u=>��E=���^�ϩ�6�l�a��,z�|��=R�3�)�'�l���*�C�D��h���s@g�e̥G�1Q��b���MOz����0�e͆���얮"؁ѭ�UQ��e$���bv5Vq�NN=i���V���KϐA�}=-g�Jrڜ���d�3WqUԦ�����c�PWE��z"̃h�U�5��&d�H�/��U�hF��*r�f���GA�$g�QO7Y�B����	z�_�*���*�[O��	z�����I�Lz�Yh�?A�5�bԮ��s�3�Ѧ���JF=m=�,T鉉���T�
h�V���I���p+DC(��B����+VE���V�k�G>jDO%�\1=�,��	��bU�䪭�s�S&�J�d�E�gf!o,H=��4* [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dmjthfy6fxyiv"
path="res://.godot/imported/Car.png-fc15a8800134eeb93976b3828bce7a51.ctex"
metadata={
"vram_texture": false
}
 extends Node2D

signal start_game
��c��]UǚY�óGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ ?]��&�6�7��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://blhysqci7cwcn"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 K�����t|	�T	RSRC                    PackedScene            ��������                                               	   ZoomGame    Car    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Game.gd ��������   PackedScene    res://zoom_game.tscn �gщڶe      local://PackedScene_ny3xl K         PackedScene          	         names "         Root    script    Node2D 	   ZoomGame    _on_start_game    start_game    	   variants                                node_count             nodes        ��������       ����                      ���                    conn_count             conns               @                       node_paths                          editable_instances              version             RSRCGST2   �  h     ����               �h       @   RIFF8   WEBPVP8L,   /��Y �ߦu�� E���"����������������������� &ߞ��H e[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c1m5ue2mc4027"
path="res://.godot/imported/parallax-00.png-f0768b4374230fb3719cdb96f926470f.ctex"
metadata={
"vram_texture": false
}
 �&���"��GST2   �  h     ����               �h       t  RIFFl  WEBPVP8L`  /��Y' L�o��@ �h�i���M[�"�G�����v�ֶ�m�`z+�+�( ��Ev���$�G�߷$I�$I����������G|����������?�������?�������?���������������>�t����r��+��5|�K���p�QrLwp��"hS�[8_�fs�t�q�7p�q�(?��7�=�����-[@Rm���ݚ�l�jC��q��P�y��<X�=�ﳂ�3��[4��������4�'R�����ɿ_4_
ߟ���Cd,eu���#���Ӭ#�"���BP�Lx:����uU�Ls0��ln\*�+��u��=u�
�24����ɁE��fo�|m~i��r��N),$���t�1�]0�������H�,�1��'0��(A�s�m��bE��ZD���f��|�����i4��:(��uo�������s�ºC�M5,-�I�j��������/5vU]R�n�|U�W��ܞ��8�/ �L%�:�g�/�+F蘍�dK�-ϵ�7�ߐ�W쬪jEH���n*W���>]�N�PtD*kh�a� fl����
����#�@�9����� AU���^(���b�YW�Ma|��}�@ƫ����s�"D���_I�.w���B�I�\X����]W�;̺��+�� ������K���E2!;j��5�W�肀��ޠ���{�`B�/IMt�D/t�+Ye`iG�\�z�����J$��b����+�m���k^��������)�%]�|1���G~υ\�V3�l�?,�'���]W�|3wm�UU � �<M��2r�W k|X6�]g�����S���n����`�hM{��Ӽ�h9�����#�n������5:�8��������<-Ⱦ��T�~1P�"P��ʩ�`���^�,�@�c��d��U^L�]���b�6���זb�ÿ���>A�����l���H�d2W~0=aI���=�X��"�!\�|�s[r4233�b����࿘r�7��W���~u{�B?�u�˖oCRcv��kk�O��c >}�9���I�6���6�T6x�t�f�>3j�>��PI�+p[���@69�7Vd�2j���*ի����3r�OG19�ˉaw��LN�c����� T�z�9?.Z�v6mD�]:�LCE?qC�Q���f�V�Ż�1E�hv˅�x�nf��H�t�9\�|!��Ti���8�H�)B����纸[�Dþ9p̞�,`w��^K�i��,��.� ���ݘX�tS�ྜྷ�a��p+!�]����e<�/V8�.\�J�M��ӻX�8�V�f�1��񊈢C�EWH��p��+��i�+9L�~��1��
td��x��NH���vh��@,���8ޥW����K��k��u����N*f�&-hi)��U;�V�hU���,,�t���Mȹ}툺����8��lJ=x���c��'o]A~ݼ�I�	v���v��$���.�^���A��đ{�1���0�7��X�+�:]�|[�5-Wc�m�)dE/pb�JR^�����x�]���M��,��5�W��uU]X����x��fW-4�̶����p�qd �EC�*߀���+S�]���$,��.�b�>�V&����2Tdb�Y�J�+_�ιIux�e�2R6�t�d-�����/y���� ��a�^��"�/Y����J�K#p!��tm�"�ܽ�ͤu�e��-�P�F��9��U�LCl"fv��%£s]���y�'�*�k�C��ҳ�������E��4�k�ڬV�:�߿w�P���\W�Gϥ{*g?+vRq;�q�=��.͙qy?7�V���t�H�	g ���Ğ?�d<�䁇�KԬ5�:�.!��`fjQ]F��f�u�w�=9�VB<��+}9]�*�JuSx�ғ_&��"م�R(��k3�"�EgD��딯�:�d��0�J��8^�J�I˲*k���={d�k>�>I�NEʦ��*���55)K=ޚ�3"ۗ���a�Bέ��t�Q`�06Ӟ���9lF��G�Z�����m+b-�X�~���6u!@TZCXW~��4��V�؝�k�*�;���h]$�]O~�ZD��һ���gXr*���H��	.��ez�j�GN�z"Mw�*߈�4�d����J��R��Xk4��,��ZY_i#:}1̄;Erk��Z��43꫕�ԥ:g�ɦ�V@eD+�;EvI.ۮ]NvӥR5L��@�1�k� 
$	�-63�+�/��ۄ���u5g�	n�
'�H\�\�:༃[un�A�K�UUhO��P�Fr��]AK��	&ŀMaE������dy��dS��+ʜ�c�W?�ɳ�o ʨݾ|j����b�~US�Er-���4`_��B��};%{�`5�<�MM�YX�]�O��j�j�\'��T�.Z`�~���J-��b��TڈdE�u";�������+T����;��&[��~��UW3P�h@SW����ׯ�ۨ����o�Ҭ7.�\�pqO�$_�!u"�"��P�8,7��[�O�f�w*w��,ED�֙+�yCzQ򕁃rP�Q��.v�����6�����ʡL�-�AY�h)�͘.J�";`��&�Y�uI�\C��҄�0�P:����y�+��m=y��ӕc��C����dr�f�Z�{�\_�(��x��Z��QI%^'��<+�Q����qI;��2"����8p@�����^��k�$��M'ǁ]���E��"��2��D�C�\T��~�s�TJq4t�J5:_�|&��bf���:��/���XphM�t$�$�������B�v�D��U�C� e9&�W�����x%��
q���7������4<�s�'(�hČ���U�Mð�s���{ZȦ��^ܹ��坱#�x4"%�h�s("q�\�I���˒��|�	bH����b?K�)�0�GF��%Nc6x�;�9�o��t�}�k��#�'��-�A�'S���Tp4��ͧܫk�ۉ��1��4/�-m�^� �=/��l(��]�6Z<���p��p+Ao2k�?��u:'6gD���>����	D3+�`���$xܤ�eu8/o~����)^a�x���|?`a��b/ ��T�5O��Fk� ���M�-v~;� b�Ʀ6���t�]��L�L��F5,�օe�tC=�T��Y���*ƻV�7��|���9C����� nZX��̚s����D9bWT�)��=�:˪�����*#�����w$��Oz�Kv�`�G������8=k��N~��W�8o#7��GO�uam0��V̨wg�|7M�]l�6�ӓ��{Ob�ñ_f�y�².ށ� �ʾL�b鳶����>�ǒk;ɵ�CϞ΋mҶs��I���92vi?��?�u?�~C=�nK�1����]X؃���m�q�k�/�oٱ�D�����8!t,�/�_`}P��������Wv%r�G���ӣ]��6��)ސ�z:��� �������%rȅ�6�.��*J�]������Co�Zvs�ޭ��3
`S_�|�{��vN!k�~:����#6�	���عw�|������F�GpG�:Q�X)��յ�N~��5�6e]9vw�mm�Z%�k��|�{i��!d������5�4�t��]�X�=��u�9�ܭ2����S�oYW_�I�g���j��;�qU��ī:�q��̠��"W$ߦ��˘0^K�u�1:n����#�MU���$u��u�NY���䫪�<��9���p�l��I�����x�s����.�p��r���~�x�x�-�8���?H:���w�w�� z�@z���d�D��B�ȩηz�~p��#XR�A늇45��ºr�?�ש�ln�"嫪�!�a���I�����ȗ?�_���.F����;Y�]G���z����3�����È��uue�oƝ*W���fG�^�)�W��j���<��G�x��ס�9L�7O����_{K�]���6ݧ���V����^pE��j����C�4t̺�8��������/���>�� �3�.ğ®�!��WѶ�|
�w �jȥ��K}<�{n�3�L�}:b�A��M
#�T?޾C���J����׏������4{bKn�|�"C�Xo�|�s���͒o���ɱuƻ&��YW��������/�}�'Z�~Z�u����� �߆�:��W�T?l����3��~+x�~�sxz��]��H�=H:����+_��oA�|���Vc��M֩�W���xn�|qU�5��r��t��S���|�s,��|�$?':_�����~����翟�~����翟�~����翟�~����翟�~�����3(���q�I�y�CP[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://djnlllj54fmw2"
path="res://.godot/imported/parallax-01.png-4d7fc7821602a4f752257e7f813722f0.ctex"
metadata={
"vram_texture": false
}
 �CR~0؉%GST2   �  h     ����               �h       d  RIFF\  WEBPVP8LP  /��Yw�(��h�C��/:Զm#q:�w��m#��)���Ҷi5O��H��?���@�����\ks,I��MJ�f�]�-H`�rD$M�͙� �&`e��d�,`
XY_P$y��:�Y�{#D���U�P�M,���%I�$I�-����9��{|�O��׻���ϻ���ϻ���ϻ���ϻ���ϻ���ϻ���ϻ���ϻ���ϻ�������\���<ߝ�~g���v�?�>�>~��÷��\��ߧYr�ݺ��u���;\WD�³�����x����7�r���:�Ι�)��罭���Xa�~�^�b��;�a�����݋��kIo�==�K]���9���9��RX�
e��&XX'�_QWS�)X
k��K�s��N��R�RX{e�����ߝ;~��2��
1|�9��}�)���� �8�ݵ�w�I�RX{ʅ�
�����S��~�����������,&n�}���8�RX��i8G�3� ���I������\�!M�c��ƿ�8�RX��wuůT�̞�^�V���A]	�>���1()����~�p!��?1������|��~��^�������z���¤�W�]�w�?�W��_�qk���4�Jn��)��U�h���=��F��\���*���䯨W	� 3�ߟ~.���~��C>�r8"�"Z~�Ya�^]�o��,P��}�?~5{�"�*����.�\ z��<� �ʩ�<Cf�ގ0�E�o�O9��ԕ��M&�݃ �
����;���Lv��!��<iu�t{��n����Ւ��HF����̐4���>er,<���DQ�n�_��L|�:��_E��+͸H(*�^��Q�P�,�m�3��Ւ�w
w����Ѥ�>@����|���<�u5#�����<1DT�Օ��1������RW��r�$)�̻�*TW��/O�g���A��)+�Q����+�Y�%���9��i�a�W�a&�N�y�E�ϒ,��X��~�J����K�ٯ�zK��<�!-~�n� �9/,>�q������nb{�|���t��e�h�"����2��<൱�#bLQ�@a�����;7�0y���5��L�Iϫ3f��
�X"������2,����M��x��A�dP]i�X��믜7}Ӹ�0I��8�o�*9�B$��(\���!���(�
�M٘mJ�[�	�'5� }K�Ç`�mu9�~GW.B�x�/\8k�|ᛊxg^���ۋ��(+1��M�u�~�*B���;��Bh��d9m�Y;�\9&�}�\ ����p[q�&��"�8iyAZ���b���_o�u�)�g҉ -�/lw'�Ȕ�lU�L��o|\d]M�M��\�k��⠬�%,������u����_7��Խ�UD[t�$sDlu�+w+��\|W���nZ�9�z�}Wv��Ѣ����J^a���_/!�ds���v�ha#ʀ�W<�z>jc=�b�8�¾L�ۢ�y�bmK]�i�����'94g��W�2����;.R�!�I���/a��C]q'+�����.ĉ/��o/+�rY����K��ȓ8|�a��9Bv�P]m� ����_�3���U}caW��4o�aһ�p�F��v^��-6������-������̯K���0|��A�A�;�&����eK���ĳ��5��y��3� �J�*T�x��Ff�)m�ח|���d��A�ȏ���������k��ۋ�+#8H$��*�7�xnS:�~'������$�]�D9~}�8k�-S����"�U�Qf��ˁBIr[�/_�[廄���B���g w�C��N�Iy��m�p��T�{�jY��?)�
�l8�?g6WW2�C��9��Ch�Pp��"�<���
�n�.?�]�-��Ö�}E _H�y[uu��.ϙKjRXs����8�s�r�6O��]XL�t:�F�|�����+��RΓ�W��5��+�b;/Vs�g�뼚n=�o��	�8��:��w�����w��_�XDBs�u��2ws�R����؉���	t�A��A�K�t�:}MN�����+�����
�kU"�TDP`k�g����?��9u�~�s�+�3�ȏ���<���2K���8:7�w!�K.(o`�G�ڭ1���Ȁ���Dy�z'��<�Z(���s�):.*�y�rb
 8~Wz�m49��]�7�!��#[���6Ѻ�N ��q���D�$�w���<o����F,?	�9l�LOWm�|�/�W;�u<b�a*�/ r���x��La�D�Ow�7��(�@<�+�c�<�va\|�o�(2�8�)LޔS� Wes���kUx���o,��U 9F�zbs�'A�`�0Q5e�����'���� XS�)'>��G/�_��i�H��zP���]bt|B������%�_x��Z��NY��������ے��nk2�C��"�#���r*H9�y��}-��L�����cJW�uu�,rOo <kܯ�H<�~I�\E�D<)_:  ����A� �"U���y�[!j��W�*��(gR��B�'z������_~���|��SH��o�S�ɢW4�T�:�;2��Ba�)�8Fh�B�C9A����qI�+�w�K TX_|�w_d~mM.yAH:�~U=�4�^$���hh��h���d{$N4�%�|(� �����2E��Nr����2��0��_ǈ)�d�sd�xLh�^v��I@�B\��w@u�?�:�b�^�WԿ�˵�zƕ��{|p#a'��#r�D��;M2E3N@�|�ÇNA�3�ɠ7g�Ɠ�����·�&�b!&L|�6��1�0<\��I���ԆoFf��M���������Zx�p��R�-*3%�^�0Q�M���|#��]-����?�AU��J����z¯���Ql\U��ddF�Д?a�X,���W�b��M��D#��|}��ѡ�+�H4H4�᝞|P�/�2C-�Z�N
N��C���l�������̳N-�[iWI��!��1?N��  ��f�wr�CJ�[�v{�A�8,�F�`?�0~"��/�y~���Eh��?U��rK����e��	~�f&=W!�̠B� �򓯊�9gș �sFH<�۴�q=�ۊ�U^�{¯�\e�\i�H�H'�ba�m�k���1�IAu�$!��;�Z�ȁ������Wz9�c���z��Z����P�w/��߮�A�.z��e�0,2S�06H�/���|���y��U7�F4�`���)"p)d�y���2"I���.�E�����W��7i��_{��wQ�
S�JrL�:W�`抺���GU����y �Z���J.l����A�h��٦��*��6��"~��Шs��l�B���\� � h�Y�J��+�� �J8�~#�B�`G��`�&v|��/�^�I��,�+E��$�]َh�q�zull�N� �5)P5A�&aL0�FFq1,���݋0U�[�=��E��Z��_������h���tL�	&�6�#1�t�䫋�bH+�t|�ʔ	�+�n��+�d���h���h�áOt`���,Π ��	*�Z�Ь�5pR��fN),�n�����z�������k>��z�2�j&�h�9�k��RՒ��OP�����n/�{+��l��~El��h}��	��d~���
�E����L�h@l���	�6�ث�u��o?� ���0`���.�2�U<�dK����/�쫠���\a�\od�J7�ߗ��_7��Su�"�@�;B��
� D����Ќ�������o�N`���ܥ3��ħ�aHV��IZ�0�"ሧ)�֢��_��@� ��2�����|�?��1�V&(���_ʤ�h��8<6Ћq�I# �.�IS�H�q�C+]-�E�6�!ʭ��;��&��X87��'��e�9Ǳ#���-�|OI'��"C!@��~�D��zܛ�JF�[3��g�ǃB`LI
6����~S�U����a #a���!X�V��@c�n2]�)�Z,3�'}���Ep��d���_��+Iƅ1���,bx	I6g��K�޲�/&���&����7��~r�H6��@>c��/J�QN��lue%�Ė�ˍhcI@0���|����s��W�/���Rh 谭G6�D_!�����#V���h	fom�:��3ǐ�.�\�� #��g���
����˰	t<�������5\���7JS������0��chCL�	����EiM�3�>�Bz� ��+�Le8�Be(���@v��u���HPlH���O���|A�����E��aR_�e�V���1G0��9Zԉ̘�@�Qo�kM��TC��g������� "����/�Ž�.,���A_G��$�kT�:��;qF6�G(z+ �
�3�r/�q�#3��;�/�f�ϫJ@�XW
��n�!���;v�M�!���u��"D>�	���ԺƯˤF�]�^��+B����`'�V,��'�'��e3�B4"nL��t1^�T�-�1~}f��6�/��� HcP�:��\����+�6RT��u�`z�o�k�m 1O��1At)� �0���p��&%����B�a��+~}a��+w��ڂ�� `C�����&i�f$.Z'0����0n���-R�7tf<�VW���dӯ����d�k�n���Ҫ�j�Q&����~DdG��4�$���UL+���������U�T�Qd���+��(x#ތ���j���5�������*I6���^��Q�60���٥�g���������jCQ3�yMi�^ˤ|�ү��\A-݊�ZÒ���_˺�od?�}��G��Bo�`?9KdcyL�vqȊ���F�cZ��B0&��.x�"J��퀇�,�H�����"��~�6��K
���l���T�H�����ŗj(�Uw���@@�I��LjJ$T��ʤ�⣬L^�ʏ�A&�������7D��ɇ�+�ԅ^�&ǉ8�=.8|;����"�3��{�/
��2�aaCp��Ԅ�@D���q]<������1_jY:ѯ�*����D����^G�%@Q�������.�fB&�q~���V�Tb-�f� Ӈg��#��ʷ�|� ��2N��uxG�������h!����>l�ȩ	;�)7 I����#��@��4�F
���Z �]k׍h��eS�XM ��%�>�K�&��a�Ԃ(� ����q������c86�4�_EJ����s�$tf��V"����X���h� BP]�-j�$r�ڷ���7�W�+scQ�#i��e�Y�3��G���ۙ~�;�D�"��\Ŝ�r󈡼�(���%ZCј%��#c���,��*��T��+�D���;�SPe U��)?�g����Mιػ~S��坯9�T�a@whJ�-d%0�r���ש���&x^W�$�)���o
��{�Z�Ы6eb]\W �`8pM�0���M�.v�_�WT�]]U��I���,�����p�˰��h�f�i��U4��I��ͤ�Y�1Ԩ)W�c*��Ev���ߔ��b��F
EE�-a��GT�$��]udB�;�/�j��j(}���^WHW�;��VK4���ࡣ���c��k�D\���&�&(�*1l���~S(���@ц�h��DzSh~P�}�7՗F�tP]�K����*�,�~SS�ޡ0Pl���e�A�<���X]�֩���X���,�ڂ�*�MM�"����=��T���Ы��g�_�X��!�N��tB�5� M匵����y����J\�V
+餓ʯc�5Mڈ�x���a�:)����S�o�ُ�Jf6$��9�7Է�&�s�ow��FI'���@�Pq&��C�5�q�H�ߝ+��Y���*~��#��~��	1���RX\o����Cp�w~)�������/��~����g��t�K��x:��x:��x:����o<��6\���~�z�x����	���o�A:_�R��3�/���/����g�t>��ʧ�bE}�;���O��/ţG �z��cZY�ޣ���VVP�v�_�ǎ� ���|5���p�=��}[���t����:�/���t��R�����=��C�=��I���*����i�:���TL��`�>�{ ��ߵ��%nڨr��߯?Ł↥��߯?�D[L]��k��r{�P��z�6׭�C~���V�� �;fx�>6�Fv�)~����l�.W��~i�n��O�X��ݯ�����F����_�1���ֱk���~��U�X7�O����&����-G������K6�ź�c<h6׼��^V}��Qk��ې�h\=�]@L��~�]o��6�gժW��N����`Y�����B�)M�7u�n�Ƶ�o�m�����]��֗X6�k��~)*z?k���Eg�_���~΂7�u�ߝ�j�m��zO(�Dmĭ��Fo���[Łj 4\�+��W~����*�kZ&:5��6c8T5m�:7�FQ'��C?��7�)mE����wCj���5��5_���ֻ~�6 $Vi=���c����rs��%j�*��{������ͫ����v��{�Z��N�{������w7,����oG��\�'��|P��W��W��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cocd6df4l47yk"
path="res://.godot/imported/parallax-02.png-dc9be51f46e2448ab77aa58c5651cd88.ctex"
metadata={
"vram_texture": false
}
 \#6�GST2   �  h     ����               �h       V  RIFFN  WEBPVP8LB  /��Y' Hq;-L���8���?Z�W�׶�E�mmA)i��V:��r`CY�}ڨ�!!�B�"�O��$G�dqZF�e{T��^�s=�����?��<�����?��<�����?��<�����?��<�����?��<�����?��<�����?��<�����?��<�����?�C��ne���nd�ῡ��K��'ՎƛدP%����7���W5�����K����� ��F��*��_+������5��oZ��N� ��Y��M���F��=�7BT��s�؀�<,��WW����+Fx�*��L�h	����7��O�PJ�i�v�M�W�̈́�i)0�9~S<%	$V�vP��W��O�L�la&l�u��M�s�� f��ݻƯ��,T!�P��;~%#�%�`U�. x8�e��I:(6f2>�w�
��?ϙ!�2	�2� �;~���r��e����Фz �B��D��q���W��*4�N��-��o�hd�DSy ��~�` ]r��-ĕJ@�+�	��k�e�j)���;�Ln�Rq��r����꾇A�!,�(�)�Uj��W��0>A��6���)��H�#n�!�����L�r"bT�ڠ���d��_���V�/Go�Q�TI*}����(�����\	F
#�%��7^(6_2�@S��$��_Ov�\X�.�=L��A��3P�z;0]n�n���T�+�	u�*{Т7��6B$�BL����*3���'���+�	�K�1b�ԍ����iU���6��䱄Z�a�{t$W,���ͣ��z��zڽ�� ɼvR�E���ä��]����MXU$�a�(��
P9d�b~�tGb!�:����NV��_Ý�>���f�<�T�D�ar�����Ԙ����w+ڭ[�GH�		�.�d���N2��)����4�l�z�-������{~7"�B�e(NL�34�����ʩ��w=P���^��� 1ZA@��y@�+oy��n,$��]�z��6�k]{� ��M��
îBL��J�(d�e�۬���N-Q\�Mj��xf/�Ʀ��G�����~2�HD̮�d}� ��
,�$�ԕ G��ب}ȩK��sd�k�;E�!-�����D��D�k�B㎃�"`LܐLu�\i��=� 	Ĵ��g�S k�ɱ���P@>OWtN�h����s\]{�ݤKj�h��1��2^^���UF���2��o"��$�=<�L�+-S�49d~׍�f��F������h4!-=����q�r��m��~2Iv�ǰF[M����W~� w�9��4 e��J�F��h�U���0��#� ȿ���*D��������������؆(ƈ{Z1�r4&i��7�.��Rf��#ڪ1��0�DL$�r��U2�c�����wU���KU��1b�g�@�#1�4i��J)�1��.��9���F�<b�zw�5��2!j��J�^f�����e���H4񗯸��SoO�{�4�w!�F����U�΃g)r|l�)�0Tw.w�S<l:�e�T!�����>�Ī2�!8����B&�h���$V�,x�ޑ�t�;grf}�b�T�Xf��[pWAl���.WF���q����y�~��hl,��
Ӕ�;�3�ܑL,�E�]�L�o^q�3�~y���|��v���;��k�%8\�Wc�w��L��Cl�j"�w����[0t�q5~ץ������N�0�1x�C	3��t��z)�F�ךּ�=���7߆^2jL�ڰ=��L�IZ[�\0��b\�_�+��w���^b���+�;�*�Ո�]����V��R����x�'�?"�˪Ȭ���-ک,���ٛ�e��2~P��#�w�]3�,��o�E�0���Ƃ����o0���eeti٬yC��W�C��ZnH��nWC�7;5�X�v,�i�6}��������wVs�6L9�_���D�6���jT�Z!�m�ܣ��i\y,;WV�w^�B�)31�'̧�>�L7 ��_5\�m!���z۟��-�����o�;4~WF�Ɨ��y I=�^�� )��%�ȯ�6�Y� �⪻�(�3:~g]�KcT��OoG���t��w^ǯv�QEw۷���S9�ﶎ�߽���L����d:�����wv<$~���������)�U��:Ŀ�L~ I��ސ��u������YHV1�������	������S���u����K�����9����z��o�vg�L�HA0n_�*�����s�r�� J�m���<@�mf]��ߓĕ���._O���۝=��Y��^������-��Y�Ư�E�����4���b��=:~��cXyc�_ׯ����!���ڬ��Ww���^������j���5�2�.1��ߙQ��z�DM5�l\}�kO�����Ռ)�񣤷�� 8�\�Ub]˯mo�����,?$��~_uq�{�����[ڭ'իJ�oKƵ`��OA���';�^cf�IVl�3P3~����;Ov��o���
"r�Il?e�����\Y�YYq�Y��������KaP�����JR�����Oy�~�ʾ����Ɍ�|�aV�Wq����)R\�G�������VS�һ��ݹ�Q��P����3�6�B�|�P��-�t����jiX�^9ߥ�-*fv`���X�����:�,�S]2����?�`��:Y`�w�_mX�M��sz�����P���Z���}����{��^Zǌ^h���0�����u�I����:�"z��^����^g�WY�޻~�F���W�z�_�Z`���j!�na���V7�_]�w�_e���_E�w�_]v���_]�:�������y��8P�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b643dq7xxcavy"
path="res://.godot/imported/parallax-03.png-e44cff5ca3054de95a4389d73dec0029.ctex"
metadata={
"vram_texture": false
}
 k���#[wGST2   �  h     ����               �h       �   RIFF�   WEBPVP8L{   /��Y Hq,�,L�޸�8�!���
����$E��%y�ߣ��AE�
��?��?��?��?��?��?��?��?��?��\�������ɯ?u��ԑ��SG��OF����6\������G� pHU2��} [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://un1cf5uxpcn3"
path="res://.godot/imported/parallax-04.png-fbf8ff28803f8ee1f407d797b77fc18b.ctex"
metadata={
"vram_texture": false
}
 ��\�3�l7GST2   �  h     ����               �h       <   RIFF4   WEBPVP8L(   /��Y P���)���������������������o	c���_�@G�7�U[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dngqlq1dsie7q"
path="res://.godot/imported/parallax-05.png-b9a77a5afb762502c6c2d02e56149664.ctex"
metadata={
"vram_texture": false
}
 ���S���Sextends Label

func _on_score_updated(new_score):
	text = "Score: %.0f" % roundi(new_score)
���GST2   N  |      ����               N|        &   RIFF   WEBPVP8L   /M� ���������  �[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b88a8o4dmtfmb"
path="res://.godot/imported/Untitled.png-30da513a925d9064453decddf41ecbd4.ctex"
metadata={
"vram_texture": false
}
 x5��d/g��RSRC                    PackedScene            ��������                                                  ..    Path2D    APM Counter    ParallaxBackground 	   Sprite2D    resource_local_to_scene    resource_name    atlas    region    margin    filter_clip    script    animations    bake_interval    _data    point_count    line_spacing    font 
   font_size    font_color    outline_size    outline_color    shadow_size    shadow_color    shadow_offset 	   _bundled 
      Script    res://Car.gd ��������
   Texture2D    res://Car.png mHx4JQo   Script    res://APMCounter.gd ��������   Script    res://APM Count.gd ��������   Script    res://Score.gd ��������
   Texture2D    res://parallax-00.png b�N촇�[
   Texture2D    res://parallax-01.png /s��5؀l
   Texture2D    res://parallax-02.png 2�8��O
   Texture2D    res://parallax-03.png B#��\5+@
   Texture2D    res://parallax-04.png ƍB��.�	      local://AtlasTexture_duenm 
         local://AtlasTexture_sjdc4 O         local://AtlasTexture_k6ye5 �         local://AtlasTexture_64kxx �         local://SpriteFrames_ff2m3          local://Curve2D_bv4hd �         local://LabelSettings_r0fke 1         local://LabelSettings_le02o [         local://PackedScene_26qm8 �         AtlasTexture                                �C  �B         AtlasTexture                        �C      �C  �B         AtlasTexture                        'D      �C  �B         AtlasTexture                       �zD      �C  �B         SpriteFrames                         name ,      default       speed      �A      loop             frames                   texture              	   duration      �?            texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?         Curve2D                   points %   	                     �B  �C                QjD  �C                ��D  �C                  LabelSettings                       LabelSettings                       PackedScene          	         names "   ,   	   ZoomGame    Node    Car 	   position    script    path    apmCounter    background    sprite    Node2D 	   Sprite2D    sprite_frames    frame_progress    AnimatedSprite2D 
   Polygon2D    Path2D    scale    curve    APM Counter    GUI 
   APM Count    visible    offset_left    offset_top    offset_right    offset_bottom    text    label_settings    apm    Label    Score    ParallaxBackground    offset 
   transform    ParallaxLayer    motion_mirroring    texture    ParallaxLayer2    ParallaxLayer3    motion_scale    ParallaxLayer4    ParallaxLayer5    _on_score_updated    score_updated    	   variants    .   
     �B �D                                                                      (�@?
   �T�  �A
   �E�?  �?                              qD      A    `�D     `B   
   APM: 0.00                                         �A     �A     	C     �B   	   Score: 0                   
     D  zC     �?          �?  D  zC
     �?ff�?
     �D    
     �?��?         
         �@         
      A   A
         �B         
     �A  �A
         �B         
         �B
         �B
     �?�̼?      	         node_count             nodes     �   ��������       ����                	      ����                  @     @     @     @                 
   ����                                ����                      ����            	      
                     ����                           ����                     ����	                                                     @                    ����                                                               ����          !          	       "   "   ����         #          
       
   
   ����          $   !       	       "   %   ����   #                 
   
   ����      "   $   #       	       "   &   ����   '   $   #                 
   
   ����      %   $   &       	       "   (   ����   '   '   #                 
   
   ����      (   $   )       	       "   )   ����      *   '   '   #                 
   
   ����      +      ,   $   -             conn_count             conns              +   *                    node_paths              editable_instances              version             RSRC2RX;�pGf�[remap]

path="res://.godot/exported/133200997/export-362256a061aa8890e9a1e558b11e5ec3-node_2d.scn"
[m($�Ԓ�g�[remap]

path="res://.godot/exported/133200997/export-1ab5dac2128a3e8bc06f45f85e03234a-zoom_game.scn"
��%��?�list=Array[Dictionary]([{
"base": &"Node",
"class": &"APMCounter",
"icon": "",
"language": &"GDScript",
"path": "res://APMCounter.gd"
}])
�T�_*N<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�%�#H9O���   9h6�E�,   res://icon.svg�g�l.   res://node_2d.tscnb�N촇�[   res://parallax-00.png/s��5؀l   res://parallax-01.png2�8��O   res://parallax-02.pngB#��\5+@   res://parallax-03.png���j5B   res://Untitled.png�gщڶe   res://zoom_game.tscnmHx4JQo   res://Car.png�#�SR4p   res://parallax-05.pngƍB��.�   res://parallax-04.pngc�H�B�ECFG      application/config/name         Bishy Bashy    application/run/main_scene         res://node_2d.tscn     application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg  #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility�����v