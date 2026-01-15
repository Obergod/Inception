define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );

define( 'DB_USER', getenv('WORDPRESS_DB_USER') );

define( 'DB_PASSWORD', trim(file_get_contents('/run/secrets/db_password')) );

define( 'DB_HOST', getenv('WORDPRESS_DB_HOST' ?: 'localhost') );

$table_prefix = 'wp_';

define('AUTH_KEY',         're%FFl#F^lA~ws.E7~#|<wdPY~wqP>+~eL}3e}M^HSyJ|K=[6t#nPr(Df!GlX+_-');
define('SECURE_AUTH_KEY',  ']!5%D5]&fQ)o/0~UaP_#DQ%<zy} PD[HP?5e ;CTcfB!L_p>Xm2g;?q#:%{.|4>4');
define('LOGGED_IN_KEY',    '#70BFvf&;b1HH/+xn)2mG-a(J^b)MzK$+X<-&$}+^bZ-[<nI],/6q&B7w}94#7bS');
define('NONCE_KEY',        '.!5(S3Le5m|qo[Csy35Rpy1A7Z}p,R*`o{kug,+a(j%mp{%cAm,?kA!w{*K N6K%');
define('AUTH_SALT',        't+*8I]E2~bp2oB(^F!,c_!feiKc|qv OK(XvRQ&%sl5w!s>M&2&C&`yWV1&5}YlI');
define('SECURE_AUTH_SALT', ')#hWIp*~SeV`-Rj-mS7l.O05><8/v`Q/Z1$X7v:s]SJ/AJ@-o4{/6i_8m?g]]nm1');
define('LOGGED_IN_SALT',   '<-EXg&nELGR0jK>&m#7 1Iz)<@-N9+&.G=Px??~r53gZ2+!t4WNQBLFXozxO)gZC');
define('NONCE_SALT',       '4a?62^QBAf*<HC`xsk[MXS]c%w~e/Vu+$7QizzV:)FHF:N=I2F>](Sib/s+7(x:)');


/**
 * Chemin absolu vers le répertoire de WordPress.
 * Nécessaire pour inclure les fichiers de base du CMS.
 */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/**
 * Chargement des fichiers de configuration de WordPress.
 * C'est ce qui démarre réellement WordPress.
 */
require_once ABSPATH . 'wp-settings.php';
