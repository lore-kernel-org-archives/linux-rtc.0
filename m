Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53001 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754351AbdHUONj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Aug 2017 10:13:39 -0400
Date: Mon, 21 Aug 2017 16:13:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 4.13
Message-ID: <20170821141327.lskwzhypx7t5gw77@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oqg5kxkcontpvzif"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--oqg5kxkcontpvzif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull this late fix for 4.13.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.13-fixes

for you to fetch changes up to 03619844d81d7459874e88034f0f36d959f0e2df:

  rtc: ds1307: fix regmap config (2017-08-21 11:08:03 +0200)

----------------------------------------------------------------
RTC fixes for 4.13:

 - ds1307: fix regmap configuration

----------------------------------------------------------------
Heiner Kallweit (1):
      rtc: ds1307: fix regmap config

 drivers/rtc/rtc-ds1307.c | 1 -
 1 file changed, 1 deletion(-)

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--oqg5kxkcontpvzif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAlma6ocACgkQAyWl4gNJ
NJKtxQ//QAby+jTEBAbC0kJtxKoWqKOTF6LEJ/ksVzJ0/xFA1FJ5LnZ9TF9oe+eS
hvt7lMQAIll6TcnXSsMLF8Bzo166ov3tOKoWfinnVE+aO7e11AMhUttJX9EBuAwS
kECR75FYcLwlhR64d36HtfdOqm+oHDgUdLxlp1PfOtbgTAqwBrgo6mdZ+k8/cAHx
8ep7foE5Ip/nlEonzhTWOk7FdCL4ROrgfZcCyV8E38T20omL4Qdpi5YrGq/XqNkm
bEauTGmoj5enz0cEmsjeS7GSp+V7cRN8TePRj/pVQefsmxOV10jj9BxsSshLLzuO
xdO4S2LEEgzmnCBxu1IcAtt8LS55VtIGGTwY9xnxivk9MG4pvU2+JqZZqUZ27dci
RHBdffQAueXpHiDw+zUPubtAJ39MO2EcgjJUDFAntK+qzAdKZD9nuf38orcNPkJi
musyxS+dx7fkrGZgc27dGBTNBsiPqWaYBDkcuY+FNtorvSyHJzEnc/6bpE7BLuUL
gGUwn91CUr7EbES1a40uojdj5epnpnoLnxPhoXruFlzsmZF8E7QL++/K9oPH+aGg
p0vXmJxBOofnotnG1qC77fkebxEfVnqYIY5iAC5HeIOE97JwMXZmHO6IKyvOyn29
sHcCzK+cjDa/LBwotv+rOLJ7zCzDBveXvGwG6oiBMF74elvCsGo=
=2PXQ
-----END PGP SIGNATURE-----

--oqg5kxkcontpvzif--
