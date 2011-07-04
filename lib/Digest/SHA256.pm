module Digest::SHA256:<soh-cah-toa 0.1>;

# TODO Write perldoc

pir::load_bytecode('Digest/sha256.pir');

multi sub sha256_hex (Str $str) is export {
    my $sha256_hex = Q:PIR {
        .local pmc str, sum, hex

        str   = find_lex '$str'

        sum   = get_root_global ['parrot'; 'Digest'], '_sha256sum'
        $P1   = sum(str)

        hex   = get_root_global ['parrot'; 'Digest'], '_sha256_hex'
        $S0   = hex($P1)

        %r    = box $S0
    };

    return $sha256_hex;
}

multi sub sha256_hex (@str) is export {
    my $str        = @str.join("");
    my $sha256_hex = sha256_hex($str);

    return $sha256_hex;
}

multi sub sha256_sum (Str $str) is export {
    my $sha256_sum = Q:PIR {
        .local pmc str, sum

        str   = find_lex '$str'

        sum   = get_root_global ['parrot'; 'Digest'], '_sha256sum'
        $P1   = sum(str)

        # FIXME FixedIntegerArray has no get_string() method
        $S0   = $P1

        %r    = box $S0
    };

    return $sha256_sum;
}

multi sub sha256_sum (@str) is export {
    my $str        = @str.join("");
    my $sha256_sum = sha256_sum($str);

    return $sha256_sum;
}

