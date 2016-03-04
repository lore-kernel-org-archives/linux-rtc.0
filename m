Return-Path: <rtc-linux+bncBDU7VC56WAFBBP6M463AKGQE42FDOTQ@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id w128si18694wmd.0.2016.03.04.11.47.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:47:11 -0800 (PST)
Date: Fri, 4 Mar 2016 20:46:59 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/6] rtc-rv3029: Add i2c register update-bits helper
Message-ID: <20160304204659.0a39f42b@wiggum>
In-Reply-To: <20160304194223.GB2970@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
 <20160304195337.51439645@wiggum>
 <20160304195611.48d5177b@wiggum>
 <20160304194223.GB2970@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CflmfS+.csZZZdxl_BPGCCQ"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/CflmfS+.csZZZdxl_BPGCCQ
Content-Type: text/plain; charset=UTF-8

On Fri, 4 Mar 2016 20:42:23 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> > +	buf &= mask;
> > +	buf |= set;  
> 
> Well, this is not exactly what is expected from an update_bits function,
> it should be:
> 
> 	buf &= ~mask;
> 	buf |= set & mask;
> 
> What you pass to the function is the mask of bits you want to set.

Meh, ok. Everybody does seem to feel differently on that issue.
I did it exactly like this with ~mask in the b43 driver and received a
lot of bashing for it. :)

But well, to me either way is fine. So I'll change this to do it with
~mask too.

-- 
Michael

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/CflmfS+.csZZZdxl_BPGCCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2eYzAAoJEPUyvh2QjYsO8hkQAKpYZQFw0sFobbCdWtOsYWD0
Pv3/zvidmaiN0qJq7LEb0+l/Ci5sE5xw2EJ/yEZA7+0wpZqFDCM+/FC42R3m89Zb
Rzt0fZAz3ZwC5WYKjvJw7zOZ3ecWKeDofH1CCh5+RyitVyPHZQG4E7Y4Xzf2Blj9
zBJPS2BXZHNS6C8gAtMwRQYirU5hBykdwBQA4AzbKglN3bJ6Cpk3axYvjVHIsucb
WMUf61QJYGZGjDpqwPyidj4K4YQ0MlgUog1sdlbFiJgiHDN9sbgs620kq3lYawFr
R2k+433owfbz86OPOY1pWVR5Wp811/3USIEvOCCxBYcTO2/eaPQRpMpoAa/LKffD
HeVJextGn24EPVk2X5r5feN0g0xn7U0BEvyQnab0EtIjV1nGvrEZetz6oVUZrkhx
MtJLnJEhciVu9sgMNjQXAu+vLiq/pIE3rPGppcq2Y9xt2t4Qkhp2Gqn+0QxkGuuC
MGgx2WA2J+o2FYXAeslWWlxpRQRPo9XZGCsGNk7BV/FIUT3ylsCpG7vcFHZTlfeG
k9DzNJWIUonNtfcmsj1XPvnfD3rILTWlHDefwZallV3heEHd26Ls0fplN0zozIme
1U8Nqn9PMzv3pA4+ZZ0H/4TOQNnLOHjJ4PTwwtOIZt3kD7asWHM7V1cD1zqVQDl1
eVSTZ587pVdpKVIgcMOE
=wNn0
-----END PGP SIGNATURE-----

--Sig_/CflmfS+.csZZZdxl_BPGCCQ--
