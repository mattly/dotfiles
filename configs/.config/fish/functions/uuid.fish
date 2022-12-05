function uuid
  uuidgen | tr -d '\n'
end

function test-uuid
  uuidgen | sed -e 's/[0-9A-F]*/00000000/' | tr '[:upper:]' '[:lower:]' | tr -d '\n'
end
