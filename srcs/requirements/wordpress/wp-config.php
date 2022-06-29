<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、インストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さずにこのファイルを "wp-config.php" という名前でコピーして
 * 直接編集して値を入力してもかまいません。
 *
 * このファイルは、以下の設定を含みます。
 *
 * * データベース設定
 * * 秘密鍵
 * * データベーステーブル接頭辞
 * * ABSPATH
 *
 * @link https://ja.wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// 注意:
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.osdn.jp/%E7%94%A8%E8%AA%9E%E9%9B%86#.E3.83.86.E3.82.AD.E3.82.B9.E3.83.88.E3.82.A8.E3.83.87.E3.82.A3.E3.82.BF 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** データベース設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define( 'DB_NAME', getenv('MYSQL_DATABASE') );

/** データベースのユーザー名 */
define( 'DB_USER', getenv('MYSQL_USER') );

/** データベースのパスワード */
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

/** データベースのホスト名 */
define( 'DB_HOST', 'mariadb' );

/** データベースのテーブルを作成する際のデータベースの文字セット */
define( 'DB_CHARSET', 'utf8' );

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define( 'DB_COLLATE', '' );

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'A;f(k[^:Wvrs-rasXht#T2S}apJm[pl5f$x%_`Y{=M#s`)s5j;Yd[hATR?{2X_.p');
define('SECURE_AUTH_KEY',  '78GiX;?jjH]B4|-wbp;C;,*Qxt/6NcKuz.fSa1}-Od6Zp 6X`V <Y2[%k;8!9w2/');
define('LOGGED_IN_KEY',    'v 1?p,=0Zh?k@6m7O|iWut6%N]eSiyQ/-HJmH;bZQt/W+^zN3lhX2ow(OY*q>6>y');
define('NONCE_KEY',        'xV>plu.SM,?I2g[rRZs|m6p=%Ihj-ks#gITjzXLQW|qJ-v{@#upt#pw07M8dJpc/');
define('AUTH_SALT',        'pO=TrrO,It0?V-rjQlq;YebAiK=%xU65+>a3}:I>rUs-*D$fw?We-s5F&_6@b&.S');
define('SECURE_AUTH_SALT', 'H-|CPNkdKj7YR9u`;HX=S Zy*>Y&<b|Vg/i*LZJ4+;>PS>*RN|Ip+G3GmmXj1| w');
define('LOGGED_IN_SALT',   '&tmnFD-0+Nb,{+SD^Q}AaXD70iFKUVhQS4gq|ew,]o0F6nsmeq27O@7znP~t<^kH');
define('NONCE_SALT',       '|dF^j.H: VkdTTaQ`#pJp$r$Gzkv[:i|`jA[!E^<Mx4]y+`<gs8~A_zLQBk(]SI@');

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix = 'wp_';

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 *
 * その他のデバッグに利用できる定数についてはドキュメンテーションをご覧ください。
 *
 * @link https://ja.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* カスタム値は、この行と「編集が必要なのはここまでです」の行の間に追加してください。 */
// define("WP_DEBUG_LOG", "/dev/stdout" );


/* 編集が必要なのはここまでです ! WordPress でのパブリッシングをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
