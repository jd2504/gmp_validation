FasdUAS 1.101.10   ��   ��    k             i         I      �� 	���� 0 perform_mail_action   	  
�� 
 o      ���� 0 ruledata ruleData��  ��    k           l     ��������  ��  ��        l     ��  ��    A ; The folder to save the attachments in (must already exist)     �   v   T h e   f o l d e r   t o   s a v e   t h e   a t t a c h m e n t s   i n   ( m u s t   a l r e a d y   e x i s t )      r         c         l    	 ����  b     	    l     ����  I    ��  
�� .earsffdralis        afdr  m     ��
�� afdrcusr  �� ��
�� 
rtyp  m    ��
�� 
ctxt��  ��  ��    m         � ! ! 2 d o c s : g m p _ v a l i d a t i o n : i n b o x��  ��    m   	 
��
�� 
ctxt  o      ���� &0 attachmentsfolder attachmentsFolder   " # " l   ��������  ��  ��   #  $ % $ l   �� & '��   & A ; Save in a sub-folder based on the name of the rule in Mail    ' � ( ( v   S a v e   i n   a   s u b - f o l d e r   b a s e d   o n   t h e   n a m e   o f   t h e   r u l e   i n   M a i l %  ) * ) r     + , + c     - . - n     / 0 / 1    ��
�� 
pnam 0 n     1 2 1 o    ���� 0 Rule   2 o    ���� 0 ruledata ruleData . m    ��
�� 
ctxt , o      ���� 0 	subfolder 	subFolder *  3 4 3 O    > 5 6 5 Z    = 7 8���� 7 H    ( 9 9 l   ' :���� : I   '�� ;��
�� .coredoexnull���     obj  ; n    # < = < 4     #�� >
�� 
cfol > o   ! "���� 0 	subfolder 	subFolder = 4     �� ?
�� 
cfol ? o    ���� &0 attachmentsfolder attachmentsFolder��  ��  ��   8 I  + 9���� @
�� .corecrel****      � null��   @ �� A B
�� 
kocl A m   - .��
�� 
cfol B �� C D
�� 
insh C o   / 0���� &0 attachmentsfolder attachmentsFolder D �� E��
�� 
prdt E K   1 5 F F �� G��
�� 
pnam G o   2 3���� 0 	subfolder 	subFolder��  ��  ��  ��   6 m     H H�                                                                                  MACS  alis    @  Macintosh HD               ���BD ����
Finder.app                                                     �������        ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   4  I J I l  ? ?��������  ��  ��   J  K L K l  ? ?�� M N��   M 0 * Get incoming messages that match the rule    N � O O T   G e t   i n c o m i n g   m e s s a g e s   t h a t   m a t c h   t h e   r u l e L  P Q P O   ? R S R k   C T T  U V U r   C J W X W n   C H Y Z Y o   D H���� 0 SelectedMessages   Z o   C D���� 0 ruledata ruleData X o      ���� $0 selectedmessages selectedMessages V  [�� [ X   K \�� ] \ k   ] ^ ^  _ ` _ l  ] ]��������  ��  ��   `  a b a l  ] ]�� c d��   c ( " Get the date the message was sent    d � e e D   G e t   t h e   d a t e   t h e   m e s s a g e   w a s   s e n t b  f g f r   ] � h i h n  ] b j k j 1   ^ b��
�� 
drcv k o   ] ^���� 0 
themessage 
theMessage i K       l l �� m n
�� 
year m o      ���� 0 y   n �� o p
�� 
mnth o o      ���� 0 m   p �� q r
�� 
day  q o      ���� 0 d   r �� s t
�� 
hour s o      ���� 0 h   t �� u��
�� 
min  u o      ���� 0 min  ��   g  v w v r   � � x y x l  � � z���� z b   � � { | { b   � � } ~ } b   � �  �  b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �   � o   � ����� 0 y   � m   � � � � � � �  - � n  � � � � � I   � ��� ����� 0 pad   �  ��� � c   � � � � � o   � ����� 0 m   � m   � ���
�� 
long��  ��   �  f   � � � m   � � � � � � �  - � n  � � � � � I   � ��� ����� 0 pad   �  ��� � o   � ����� 0 d  ��  ��   �  f   � � � m   � � � � � � �  - � n  � � � � � I   � ��� ����� 0 pad   �  ��� � o   � ����� 0 h  ��  ��   �  f   � � ~ m   � � � � � � �  - | n  � � � � � I   � ��� ����� 0 pad   �  ��� � o   � ����� 0 min  ��  ��   �  f   � ���  ��   y o      ���� 0 	timestamp 	timeStamp w  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Save the attachment    � � � � (   S a v e   t h e   a t t a c h m e n t �  ��� � X   � ��� � � k   � � �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
pnam � o   � ����� 0 theattachment theAttachment � o      ���� 0 originalname originalName �  � � � r   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � o   � ����� &0 attachmentsfolder attachmentsFolder � m   � � � � � � �  : � o   � ����� 0 	subfolder 	subFolder � m   � � � � � � �  : � o   � ����� 0 	timestamp 	timeStamp � m   � � � � � � �    � o   � ����� 0 originalname originalName � o      ���� 0 savepath savePath �  ��� � Q   � � ��� � I  ��� � �
�� .coresavenull���     obj  � o   � ����� 0 theattachment theAttachment � �� ���
�� 
kfil � o   � ����� 0 savepath savePath��   � R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  �� 0 theattachment theAttachment � n  � � � � � 2  � ���
�� 
attc � o   � ����� 0 
themessage 
theMessage��  �� 0 
themessage 
theMessage ] o   N O���� $0 selectedmessages selectedMessages��   S m   ? @ � ��                                                                                  emal  alis    (  Macintosh HD               ���BD ����Mail.app                                                       �������        ����  
 cu             Applications  /:System:Applications:Mail.app/     M a i l . a p p    M a c i n t o s h   H D  System/Applications/Mail.app  / ��   Q  ��� � l ��������  ��  ��  ��     � � � l     ��~�}�  �~  �}   �  � � � l     �| � ��|   � , & Adds leading zeros to date components    � � � � L   A d d s   l e a d i n g   z e r o s   t o   d a t e   c o m p o n e n t s �  ��{ � i     � � � I      �z ��y�z 0 pad   �  ��x � o      �w�w 0 n  �x  �y   � L      � � n      � � � 7   �v � �
�v 
ctxt � m    	�u�u�� � m   
 �t�t�� � l     ��s�r � b      � � � m      � � � � �  0 0 � o    �q�q 0 n  �s  �r  �{       �p � � ��p   � �o�n�o 0 perform_mail_action  �n 0 pad   � �m �l�k � ��j�m 0 perform_mail_action  �l �i ��i  �  �h�h 0 ruledata ruleData�k   � �g�f�e�d�c�b�a�`�_�^�]�\�[�Z�g 0 ruledata ruleData�f &0 attachmentsfolder attachmentsFolder�e 0 	subfolder 	subFolder�d $0 selectedmessages selectedMessages�c 0 
themessage 
theMessage�b 0 y  �a 0 m  �` 0 d  �_ 0 h  �^ 0 min  �] 0 	timestamp 	timeStamp�\ 0 theattachment theAttachment�[ 0 originalname originalName�Z 0 savepath savePath � (�Y�X�W�V  �U�T H�S�R�Q�P�O�N�M ��L�K�J�I�H�G�F�E�D � ��C�B � � ��A � � ��@�?�>�=
�Y afdrcusr
�X 
rtyp
�W 
ctxt
�V .earsffdralis        afdr�U 0 Rule  
�T 
pnam
�S 
cfol
�R .coredoexnull���     obj 
�Q 
kocl
�P 
insh
�O 
prdt�N 
�M .corecrel****      � null�L 0 SelectedMessages  
�K 
cobj
�J .corecnte****       ****
�I 
drcv
�H 
year
�G 
mnth
�F 
day 
�E 
hour
�D 
min 
�C 
long�B 0 pad  
�A 
attc
�@ 
kfil
�? .coresavenull���     obj �>  �=  �j���l �%�&E�O��,�,�&E�O� #*�/�/j 	 *�����l� Y hUO� Ԡa ,E�O ɣ[�a l kh �a ,E[a ,E�Z[a ,E�Z[a ,E�Z[a ,E�Z[a ,E�ZOa �%a %)�a &k+ %a %)�k+ %a %)�k+ %a %)�k+ %E�O K�a  -[�a l kh ��,E�O�a !%�%a "%�%a #%�%E�O �a $�l %W X & 'h[OY��[OY�GUOP � �< ��;�: � ��9�< 0 pad  �; �8 ��8  �  �7�7 0 n  �:   � �6�6 0 n   �  ��5�4
�5 
ctxt�4���9 �%[�\[Z�\Zi2E ascr  ��ޭ