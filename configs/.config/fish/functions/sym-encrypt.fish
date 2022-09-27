function sym-encrypt
    gpg --compress-algo BZIP2 \
        --bzip2-compress-level 9 \
        --cipher-algo AES256 \
        --symmetric -a
end
