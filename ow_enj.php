<?php
include_once("slider_template.php");

$link = NULL;
$userData = "";  /* main user data */
$userDescriptions = NULL;  /* strings for <p></p> */
$userDescriptionsCount = 0;

$ID = 1;  /* content user ID in database */

define("DBNAME", "onewaydb");
define("DBHOST", "127.0.0.1");
define("DBUSER", "root");
define("DBPASS", "");

define("dbNoResult", -1);
define("dbOk", 100);

date_default_timezone_set('Europe/Moscow');

function dbInit()
{
    global $link;

    $link = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
    if (!$link) {
        echo('db open error.');
        exiterr(1);
    }
    mysqli_set_charset($link, 'utf8');
}

function dbClose()
{
    global $link;
    mysqli_close($link);
    $link = NULL;
}

function exiterr($exitcode)
{
    global $link;
    echo "MySQL Error: " . mysqli_error($link);
    die($exitcode);
}

function SetCP()
{
    global $link;
    $str = "SET NAMES utf8;";
    if (!mysqli_query($link, $str))
        exiterr(1);
}

function dbSelectUser($id, &$row)
{
    global $link;

    $str = "SELECT * FROM onewaydb.persons WHERE id_person = " . $id . ";";

    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);

    $i = mysqli_num_rows($result);
    if ($i == 0) return dbNoResult;

    $row = mysqli_fetch_row($result);

    return dbOk;
}

function Let_God($year)
{
    if (($year >= 5) && ($year <= 20)) {
        return 'лет';
    }
    if (($year % 10) == 0) {
        return 'лет';
    } else if ($year % 10 == 1) {
        return 'год';
    } else if (($year % 10 == 2) || ($year % 10 == 3) || ($year % 10 == 4)) {
        return 'года';
    } else if (($year % 10 == 5) || ($year % 10 == 6) || ($year % 10 == 7) || ($year % 10 == 8) || ($year % 10 == 9)) {
        return 'лет';
    }
}

function birthDateStr()
{
    global $userData;

    $months = array("января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря");

    $udate = date_parse($userData[4]);

    $fromTime = new DateTime($userData[4]);

    $interval = (new DateTime)->diff($fromTime);

    $year = (int)$interval->format("%y");
    $s = $interval->format("%y ");
    $s .= Let_God($year);

    return ($udate["day"] . " " . $months[$udate["month"] - 1] . " " . $udate["year"]) . ", " . $s;
}

function birthDateSecondStr()
{
    global $userData;

    $fromTime = new DateTime($userData[4]);
    $fromTime->modify("+1000 years");

    $interval = (new DateTime)->diff($fromTime);
    $s = $interval->format("%m месяцев и ");
    $s2 = $interval->format("%d дней до ДР");
    return ($s . $s2);
}

function getDescriptions($id, &$rows, &$n)
{
    global $link;

    $str = "SELECT * FROM onewaydb.descriptions WHERE id_person = " . $id . ";";

    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);

    $n = mysqli_num_rows($result);
    if ($n == 0) return dbNoResult;

    $rows = [];

    for ($i = 0; $i < $n; $i++) {
        mysqli_data_seek($result, $i);

        $s = mysqli_fetch_row($result);
        $rows[] = $s[2];

    }
    return dbOk;
}

function getContentText()
{
    global $userDescriptions;
    global $userDescriptionsCount;

    for ($i = 0; $i < $userDescriptionsCount; $i++) {
        print("<p>" . $userDescriptions[$i] . "</p>\n");
    }
}

function likesCount($image)
{
    /* LIKES COUNT */
    global $link;

    $like_count = 0;

    $str = 'SELECT COUNT(*) FROM onewaydb.likes WHERE image_name="' . $image . '";';
    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);

    $count = mysqli_num_rows($result);
    if ($count == 0) return dbNoResult;

    $like_count = mysqli_fetch_row($result)[0];

    return $like_count;
}

function getSliderContent()
{
    /* slider template usage */

    /*  get images */
    global $ID;
    global $link;

    $str = "SELECT image_url FROM onewaydb.images WHERE id_person = " . $ID . ";";

    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);

    $n = mysqli_num_rows($result);
    if ($n == 0) return dbNoResult;

    $rows = [];

    for ($i = 0; $i < $n; $i++) {
        mysqli_data_seek($result, $i);

        $s = mysqli_fetch_row($result);
        $rows[] = $s[0];
    }

    /* LIKES COUNT */

    $likes = [];

    for ($i = 0; $i < $n; $i++) {
        $likes[] = likesCount($rows[$i]);
    }

    /* slider  */
    $s = '';

    for ($i = 0; $i < $n; $i++) {

        if (isCheckedOrNot($rows[$i])) {
            $s_checked = ' checked';
        } else {
            $s_checked = '';
        }
        $s_onclick = 'data-img="' . $rows[$i] . '" onclick="toggleLike(this);"';

        //  image index ONCLICK CHECKED index likes
        $s .= st1 . $rows[$i] . st2 . $i . st3 . $s_onclick . $s_checked . st4 . $i . st5 . $likes[$i] . chr(10) . st6;
    }
    return $s;
}

function GetClientIP()
{
    return $_SERVER["REMOTE_ADDR"];
}

function isCheckedOrNot($image)
{
    /* return TRUE if image "liked" current IP*/
    global $link;

    $ip = GetClientIP();
    $str = 'SELECT COUNT(*) FROM onewaydb.likes WHERE image_name="' . $image . '" AND IP = "' . $ip . '";';
    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);

    $count = mysqli_fetch_row($result)[0];

    if ($count > 0) {
        return true;
    } else {
        return false;
    }
}

function deleteLike($image)
{
    global $link;
    $ip = GetClientIP();

    $str = 'DELETE onewaydb.likes FROM onewaydb.likes WHERE image_name="' . $image . '" AND IP = "' . $ip . '";';
    SetCP();
    $result = mysqli_query($link, $str);
    if ($result == NULL)
        exiterr(1);
}

function setLike($image)
{
    global $link;
    $ip = GetClientIP();

    $str = 'INSERT INTO onewaydb.likes ( image_name , IP ) SELECT "' . $image . '" AS EXPRESSION1, "' . $ip . '" AS EXPRESSION2;';

    if (!($result = mysqli_query($link, $str)))
        exiterr(1);
}

function toggleLike($image)
{
    if (isCheckedOrNot($image)) {
        deleteLike($image);
    } else {
        setLike($image);
    }
}

function QueryValue($name)
{
    $s = @$_REQUEST[$name];
    $s = str_replace('<', '&lt;', $s);
    $s = str_replace('>', '&gt;', $s);
    return $s;
}

error_reporting(E_ALL);
ini_set('display_errors', 1);

dbInit();

if (QueryValue('action') == 'toggleLike') {
    toggleLike(QueryValue('img'));
    print(likesCount(QueryValue('img')));
    dbClose();
    return;
} else {
    dbSelectUser($ID, $userData);
    getDescriptions($ID, $userDescriptions, $userDescriptionsCount);
}
?>