Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBP5WX3CAKGQEUVS2WGY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si1093330wmf.0.2017.01.30.11.59.58
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Jan 2017 11:59:58 -0800 (PST)
Date: Mon, 30 Jan 2017 20:59:48 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.10
Message-ID: <20170130195948.awqujnclhsydbqeb@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aca2rbkzm5b6q7l5"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--aca2rbkzm5b6q7l5
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Linus,

A single fix for this cycle. It is worth taking it for 4.10 so
distributions will not have CONFIG_RTC_DRV_JZ4740 switching from m to y
in their config.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.10-2

for you to fetch changes up to 586655d278ba08af7b198b93217746f9a506ee8a:

  rtc: jz4740: make the driver buildable as a module again (2017-01-26 23:03:21 +0100)

----------------------------------------------------------------
RTC fixes for 4.10:

 - Allow jz4740 to build as a module again by using kernel_halt()

----------------------------------------------------------------
Alexandre Belloni (1):
      rtc: jz4740: make the driver buildable as a module again

 drivers/rtc/Kconfig      |  5 ++++-
 drivers/rtc/rtc-jz4740.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--aca2rbkzm5b6q7l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEl0I5XWmUIrwBfFMm2KKDO9oT4sIFAliPmzIACgkQ2KKDO9oT
4sIjow//V7xFYMDMMTGMLWlkvtgCfnc2qBXUmZWKD8d7lCVMQ4vzvYZi9dELGvom
gW7YYw30x01xCAjXlroT3Ynvn0qL8LzUvYRZokncy8vRONV8D2TO04u0LDxvXXg+
pI92xD9SwZJFW91plCF3papuvEvy11S5p1gUDvvdToH+3i8ZI6NrSQrUQ1G4/FtT
htT+rkP0eJx9Pjelr0mLcCb6wEKtPSG8K6t3GYYebP4QdtnluFd9DHxwWCQezG2T
3pb8P1cYgslCYsYz5cKyoAljWtGQlW/TQQRQmwZTRJxyoz4a5QouFsOwVZmdAuSs
K5okXVlF4JEqw34oiqG/8RwZvgooZkdNuKnknkFv/G+3+cu9sn2Kpsn8IwM5Vi7c
qquahHB8tEDBtU5bf1w1wICxmbjmOrMQ5CM8AnnhkvhdMznGTn+7tt3yTxXu6yuQ
WbY5xeWLPLJvyw7MJU9JkjA8X0J8gb/txDKQo+nDoSVoLtr5kzWqfVnm2BlFLFah
kjhdJHLXbhMgrUf2b8kdEO4MWnS8vxzVNKST5py75jEwIyHuvsB6wCUsugwVq3Ra
Z5ewcBkHC2vaS1OT0zIZ1rbCBfgvXvhUhyk14Nzg/8sFyqssePakKI72en1jFnWt
eeyOC2xAebyhaRfhedKkeGu+NZTbrqFyaFf/9tBHBqF68iQgdEw=
=p+I6
-----END PGP SIGNATURE-----

--aca2rbkzm5b6q7l5--
