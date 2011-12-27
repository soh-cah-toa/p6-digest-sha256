use v6;

use Test;
use Digest::SHA256;

plan 14;

my @str = (
    'foobar',          'c3ab8ff13720e8ad9047dd39466b3c8974e592c2fa383d4a3960714caef0c4f2',
    '42',              '73475cb40a568e8da8a045ced110137e159f890ac4da883b6b17dc651b3a8049',
    '133+ |-|4><0|22', '86a5a8c1b2e5ecf87d0da1913e109c314d860acbff365f4eec05be4159c26ce2',
    '\b\t\n',          '055092a537801b5b300e5ec63a707a6f354e802e8db68c4bc2dedbabe6c5c3cc'
);

for @str -> $msg, $digest {
    is(sha256_hex($msg), $digest, 'Str type arguments');
}

my @list = (
    ['spam',  'ham',   'eggs' ], 'b8e454a18544ad45ed4205b8c06d0358b057b1824f96b91529bbdc16bc10b3a8',
    ['3',     '1',     '4'    ], '748064be03a08df81e31bd6f9e7e7c4cc9f84b4401b9a3c6e85b7ff816d3ba68',
    ['d-_-b', '(^_^)', '(>_<)'], 'ace3630b5d6a3b51e96f5a536e1794aebbd7f1acab351ba5d00f9666d2852f49',
    ['\v',    '\f',    '\r'   ], 'a54d908fc57a1c513dd19b3ab68c04601ecab872690084ddec9facf39b799257'
);

for @list -> $msg, $digest {
    is(sha256_hex($msg), $digest, 'List type arguments');
}

is(sha256_sum("foo"), list(740734059, 1761592975, 4187702588, 489701684, 323104112, 1686355872, 4186594952, 1650911150), 'correct int array created from str');
is(sha256_sum("bar"), list(4242418478, 3685051380, 140517303, 570334044, 864882926, 1117691983, 2924810678, 2411696057), 'correct in array created from str');
is(sha256_sum("baz"), list(3131416726, 1295196411, 3234244898, 335827912, 1363059274, 3103589751, 55051433, 1730445462), 'correct in array created from str');

is(sha256_sum(['fish', 'chips']), list(4010022330, 2951128356, 818387141, 1671446482, 1987488175, 3945630504, 4085708939, 3943861802), 'array from list');
is(sha256_sum(['salt', 'pepper']), list(2467830826, 1409115585, 3621403270, 1431163980, 1688474892, 65164852, 4048750178, 1828287433), 'array from list');
is(sha256_sum(['cats', 'and', 'dogs', 'and', 'elephants']), list(3251334942, 1552458806, 1598266799, 1645003775, 2335798701, 1518402238, 3373162856, 4203707799), 'array from list');


done;

# vim: ft=perl6

