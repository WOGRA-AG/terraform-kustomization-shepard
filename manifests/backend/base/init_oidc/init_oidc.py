from typing import List

from cryptography.hazmat.primitives.asymmetric.rsa import RSAPublicNumbers
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
import requests
import base64
import six
import struct


class JWK:
    use: str
    sig: str
    kty: str
    kid: str
    alg: str
    n: str
    e: str

    def __init__(self, use, kty, kid, alg, n, e):
        self.use = use
        self.kty = kty
        self.kid = kid
        self.alg = alg
        self.n = n
        self.e = e


class JWKS:
    keys: List[JWK]

    def __init__(self, keys: List[dict]):
        self.keys = [JWK(**key) for key in keys]


def intarr2long(arr):
    return int(''.join(["%02x" % byte for byte in arr]), 16)


def base64_to_long(data):
    if isinstance(data, six.text_type):
        data = data.encode("ascii")

    # urlsafe_b64decode will happily convert b64encoded data
    _d = base64.urlsafe_b64decode(bytes(data) + b'==')
    return intarr2long(struct.unpack('%sB' % len(_d), _d))


r = requests.get("http://dex.auth.svc.cluster.local:5556/dex/keys")
jwks = JWKS(**r.json())

key = jwks.keys[0]
exponent = base64_to_long(key.e)
modulus = base64_to_long(key.n)
numbers = RSAPublicNumbers(exponent, modulus)
public_key = numbers.public_key(backend=default_backend())

der = public_key.public_bytes(
    encoding=serialization.Encoding.PEM,
    format=serialization.PublicFormat.SubjectPublicKeyInfo
)

with open('/var/shepard/id_rsa.sh', 'w') as file:
    file.write(f'env oidc.public={"".join(der.decode("utf-8").splitlines()[1:-1])} printenv')
