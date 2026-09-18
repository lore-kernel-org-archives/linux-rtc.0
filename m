Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4D3B9DA7;
	Fri, 18 Sep 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738085; cv=none; b=oczrcDTjNNWI7s+gl3vgGridP6bKRGFn1FBqnPYs6I2jXFK7jhRDk+QKiqh4V7ENvUlFN5zpD4Kf4hllkjCE4fBk+6NfkNSB+tGapEqe9jLB1iJGGcskBTZr6aXS0h40ChaZhzLKwUmVMp55TA8ZdEFd87/ySUcfwWnUpW3SweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738085; c=relaxed/simple;
	bh=tWBf3uyILrUDAJtvdPXuryNrkJPM80BM9EJ5GBYNinI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKdqFPF+RsKHwJStLH7R0Zky7RnJsh5OUiLMJIIoi8lL3jUgaW8FVPghY3Pbxcz5SetSDVR5J45McSPbd92N1M9yU4c7Qm/ROK9qG3YW2MvSiwWeSypTP0A69LXwJNPFWDsL8E+DoasV++7azz59fhGKzQzw3HMM55bZUgnlLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WJdEzlJI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WJdEzlJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1789738077; x=1790342877; i=wahrenst@gmx.net;
	bh=tWBf3uyILrUDAJtvdPXuryNrkJPM80BM9EJ5GBYNinI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WJdEzlJIvx8bw1M/GUuZlpMQ2jaHBVyzWV6jjaNDVnNQGQyfUI69v+Tf/p4Ax2TF
	 UttyxOJBHnEhSeU3SUw5at7FBBbC+7+LF4OiudjYWa+aun81rkGk3UyNJ6c8HFu9B
	 kZ7e1gCanF1uKNrWQ1ByKALIceuMBVU4I7Gq37VmYhpdaDPSdIwRg9mcy66ArYRXM
	 RObFB1kW/NclvQHnbiJw4aRU3Mp9EbkHRFf0stCtY3dflHkWz2iS2wOyKSZ7ZWKyv
	 8vvuCjFkrQzD/tJxwtl4mC9Zp9wB8hEXpAH4YG1ILC/yrSbBw6QTjoMwml9EQL4mO
	 KjuRaZmbhMqrUimrJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1wngOa0AVV-00uKZk; Fri, 18
 Sep 2026 15:27:57 +0200
Message-ID: <f5c04c5a-20c3-4f4c-bd1f-045516d24140@gmx.net>
Date: Fri, 18 Sep 2026 15:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-2-sander.speetjens@gmail.com>
 <20260918-steadfast-unselfish-loris-996d7d@quoll>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260918-steadfast-unselfish-loris-996d7d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YM9mY3BXzxwtZ4RijvGUzw5t0U1vAoX2J50Abq90Tspt8fuJUgC
 JgowxUrx1jlVHDyx4oiNPaNBNBpY6rkN1aXy/swMP6o+SeZuxvsb+z5B6kfy4czNI42opC0
 Uvct3pjR1yHBPfSt7xuE6/QDxoFOSNhnLxboQgYs39gKU3cGt+PFtAzszAZ20NT0TXJkuGP
 12iXaMIMa8UUciIIYp8zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vs+CRJ0HHgw=;kbGpGyCssjWI5MIS2QEhNXFQCIJ
 KVDemmyopehwdFVoscfIXt6+m20sR8z4Wnv461AQ/jbiyy+RipgJCI+SCxRohvIS5Xsf5eeE/
 Qw3i4e1uyNsmHUN1SSdNnftnt6haKDeAB8vcZhLIUsDyLfNHNq18Gd9dpUs8unT40wiRDmT5v
 My54x5O74nhLcUj4FfIMlGHROtiJrzvsl5nsy3MmACoyDsR6WQM00h/suXGHRIsOqnPZY/c/h
 MJN8HvOBTzSVen0Nd0btvB17ElH5CRXTYvmIUs68kbV3LE1j3Yh5WvLdDppFQedFcflJ0/81d
 3JHfTRiNCVj7wgi/3gMDNqUjmNk8LXGBqhOT/CD6aP7UMxJGf/tejlKUzIGinLvJXxHG69yc6
 IxI8jEKw5AjKhvsD++8d8bhYmYNz+T+WtRB9YyzN1PBni40l3DSlyx7oNaR2Gh9Fd+HHVfJB1
 fWaPsEfsJk2YgZskEqJOuHETKW/vbywIr1YGwPjXgeOZ3MvulAhcr9hN0lnUEc74djBGDAyAp
 Lx1c0wmACcUGSyus5zFufefZx9IeHLpb3q12PUDDYhrLtiWSKGNs08JVRTIUCva5pPCPFyiNO
 LM6ODceVO1jos7u/Z+o5mbplykkBucwc3z5p0TlDOLyYcMh3UeSfBqTOuSzj5L1+b/+675v0Y
 2hPaNLgRrrVtuKIi3RFCg3cF2UJhJo7YN5fXPLjPO6vtAoH4DgvpFwt7MqC4N1qDnvTTSPNL5
 r67AspJ4hTOSjiaNiHLFtWS7oE17u4gaMj5GD0SBhr+FWgh5wyJqgECu1g33np7uz6nS5pmoN
 svnYd8sezdmPgPK2NLdP0tTZ7jEFw5izANEcqBXWgmuiE9VhO4+FOwdarFhYgqUaOaa/ZnNyl
 RBfJlV6SYTUuDcCF7JQvuUS2Mz91yDRkZbzWaa5/Nxu358ucYwHlc9KFyXrL0JC8zU18fmwG+
 FR+gLasUf/IozRxE1e9D1TQJbEWPKpEzNuuBCGIj3tN/yWBfI5yP+mcnuoh+l+qRkhzB5ozZC
 2SPIQvBOrrKmCOyBpHclaJL7HavBjzkmY+ZXbQ6ELhbWp9QtgV1MEL3PCKFWm6/ShuHnhKDTc
 gjrmkWdRyGQly4dbdAlrx39flBXVXTm1JI4E9Rx6MshQWPR9KZxqZw9mtwtPxQZUhOpzpZ1tx
 msdbxMy2YCH5UAW5HOxaURAP6QrWxmyWnTLf3LKqpCnLEfFMYSX0xAwHL1BqOqrU+qlS7Gpm0
 /zhuvwGtyMEwO9nJcqOozfZvG4iv5jrRtYCwEWAxZvzUKbYn/EvKrpM3yiNRxfYU7x+uLHFEO
 yhbnVyLWv+iPKr2f2U334lShqg+27aPOPhbWElvykAh0jHp3ynnswOi8gZ077f3bAaAAKMkEN
 8IM03bkNvujpcRRDHAFeb3hC+Q32Htr3RpeDOvUdIgQo9gK/tjr9AuKHCyNwwUjk6YRNaf78X
 /QqU2PRm8rXk7h4PyPj9Ey3be1VSlYpNafn0yaEFXp5lF8xafRK/kd/lbkriv3seW28XewBm8
 LTCrkJek8mbveQuGZvkMRSkBarUkqzxJa2QLAkk52OEL5QWP7EAF9nSnoDxKgpWl7S3V3lafs
 /Cs7OOOan7eNqjuXvLGJZyh8dhdZbq6EYZwqVIEFS7ExnLKQX4b6nXyckDNRoLiVNuBNgmwvP
 ENLeLyhCM+cxhYXBs67f53P2LbOZhlQdIlKEJfqEgAdW+Lq3X3yJ/98CL5lziEDP54WG/EoJd
 na2VTs5Iwgnk+bsbXV2qXupgjv6zRxgSo7AwsOGokewfbIJhl1hu0+kXbxfWp4esqbeb4Qvav
 l1Z00Z9JhnpExLAbZfBlrUWB2vQlX8E//YR/F+6NMBqAzgpECmHZvfjm5Y/pYCbBVSkARd+or
 ighErngAk0boTCSvhOnZey1X+XA086c06E3ftzoeepMUDlMratbTsiUC5JqqaHTb0whDzuDlK
 UwpUBNMv/cufZmg6rAfsRIA91DlEJrbLagnTfHBLPXJ3j4MqfdBjbu0BwcNTivPC8xh/uRWu2
 Y4N4M25sGiThelyvqHsZ6kpUqekyJkQHr7n0MS4K2cl+5FjEwDVpGcblKUIZt6P6nnw5JP9Yd
 8IeAuUf2NflwoEyJfwAXLq3UqClupoA9GMcr3nFK3tjV8tzRyZ7GOZVdUrXcrU1teLUN8PZE7
 HP6SVqA9MvNTz3hcyCjpH70/xwmPO8Edq8NXkG4BvFqNSyyA6Hya+4rl/WyXsInqSHryQGxBm
 69fwHrwgGg980w6X/vxhCJZnBYz6t3IU0h2tRmkt+hy1sTdILcieHED30Z1Y5JVDcMEETqI4M
 MBhnvm/Uxy3P5QHHLQ3TtRvKtBEPz8E4YxvIK5i5mmlnXPYJ8bBsOKbuTgQDzbl1UCoNm6FQ2
 cNVGBxfGKeZgTbEWXUyFKdAayZ9HPpVSozV8YiXxmcWGy0DRx1me4vMyJfcFmgiL7mZ7RFo1X
 5IQ26NutmBJq7gtA+OEqwl9zqS4OvasQ2rubDpUuTUs9J+F1pH5kXqgD3IHcexCwrtEPLv00v
 DZLpN9XLTbtpKlzax9na/HkUwjE+SVEL+r+Wa6ZgUXoeIDyPM771RMRvcEF6NAtcjOohCf78i
 FQMI0dMvxfHQ35mZFmwEpPrxubSigJLK9B1iV5gkcF58aVfCVPtsSrd+S02fgdXsrXaSjcNLI
 F4K3eSOHZXwR3IOUen1O7U1ZneHCq7JiLinZHfi8ajtlZ/hERwchQ4DeXo4IPvxkJW9g7jgc5
 ZKICZOakFRMbNbFQ1x8qGGb4bXwjxF+bcr1GpmdJadcN52CFNe8Qqm3qJCub+4+BxL9FQO8uo
 vyCo1PjBJzQC+fjrPWDwPCHllO1J0yMWWTqOUyN2YRG8E7+mDiTFqEeoWwTISPM5+s057AMip
 yRoHc69XjkEM9Kp85SzvMz9wqC4mm8nsbarsoq2Aq+rksi3ZYvtanv6deFBLxbBTRMybKvu/J
 jwlXs/QV68R4WZnJ+OnEwyI4xmmjPaaVPLPy/XLSx77HRERnyBwKoNN2fe4ynNhXKuVlCv/8q
 AqMPR/GF34Wip7R+dRpPm1JtDMQPqtagGPu4xo2W3TI0iP1tT34Lnyncn1SCn0PdyEhwcmOgx
 Gz7qsABRghzrg5LhVQsgweNvlVGne8aQehQbuPjfk6umCe2Ikxtacq04zYBBUV9xH5YWXyUGF
 QG2X6heUohRzpFVY9ckEHGSJ5TcTzjLv41/sw9St16HcHjwrqDM//6R0ycD8q6aL5AucD4ujO
 luaxyURVn0+d9Pq8qyn9Ie3YXgD4bpENmFa2UdMcTlU7cnZWZxSkPFwNf/XQzPolLh/Qic1kL
 e593N44442YVzQ9wsDe9AXU99nQb+Ji+HRMCCVvjEo2kfLHXqi/Il0F1+a2Y0RXnwNodnqrfh
 wafuI9+y8F3hxtiSFH5lfZ1ct0e6t83Pp4UCZuyNKDxyDiwcw/MzDYkMTE8Ni3b9UvdLDNLPO
 5UZhiGFAglCnBji6p2h1unAXx9RnBtZ5ObI6akP5axksEY8N6aAZmUBPljOoHYUA/ZMY0U2QH
 sCY5VGmuD3lMmMu6jlYzSXrInU325YSuCHV0e/PX21tOh/Z6bW0VxCZ+xaOhzy0ap22NyCnKI
 v+/A2Nwbthk9OR1EpVAm1Q86AGSN7/+UdaE3EofZhxmkVetqatYG957m4gole/g9EfTcN/en4
 VTQV5/pwqkGsVMOs53fysY990AWLeUJje4Vekm8FPfLbkBbx+H3BChJT0L8gestHEUCFDj38+
 9rpV0UFAutQ/1Ukq6PmonONZjAV1OakVS88CYtqUsHmQDZDzeeOX4kYb+IqDoJxS6g3JPhv3T
 GQSfw/5j0Ijz9bNfWfCBN0CCARZCWBYhyatYLsJUbLPlODyRTPC07NPIa/odiedfazCceNuRi
 4sn/nTnjiUKKurpHAJ0opjZjl6j04z0qQHsa2qqsF0GF+MhzQonsgR64MhFCTJFUtIHSBsicA
 3tn3G+a4FdmfAlE07xT5wB/trKgYsFVZTszlcItnRIgbId/8szbOC6FGf4c6pp4xZPSZ/uSy6
 1abfsmp3mZ/nv9kW4swiQlDT4XWvtqFncOjHc+cstUMHEL2+sI9QG5+MFIDQC9ucVj186xlTI
 wEKMhtKVTAhsbGob1lT2Pw8iMYHYanuBsos4VzWItV9+Ntn7ADnd2+UChNd+8nABTVNvOJc9z
 7+MbQ/SGNCZMgUbX+eY3nnpsHUg2YTd/5JL4H0++72kyyWRVaPhNtmef2wFWXOPCsWCoTc89r
 s74W3MhgwtkduwT3befOAxyJpC2F46r9wFZqaBWw38ZQU4bz8cfFgbkyVwqjReik2/7xRbLps
 qfuPcvEgwDPmC7/mNM2KaRzhcvh0/C0mtY4Ju2aL991fVdnCNjE3xqPvxReXSv7/8oJXkzcbL
 kRkPN8GGs4jrMkZYilbD5juwzXxJidGnUpHshHm1S3qI3ksA1mziUejd6vuOVjIu3Wd5VFBfV
 +3IaP2+GQ9012250KYpzd5zYJxgisx7IfWxJD3vzcU0UHFsAQLcVVrwlZU263PjasqswlwanF
 kspV8GqK0WHm43Dp4O4hcG7Y5uQREfwOv51NAjuZU5HnqCMl4OuM+EuMtPRLbm3jQNHzV12//
 KigxQYwlIM+6eTDAtUBTqnJ+wSai0z8KoziuGxFjMHvFFY446vgIjvEYv9gHozEeU3e1wS09R
 VuK515KE/S6EsUcDaADG5fQrQSnDrr5xVFnfNVu/hjfYBNT2l8TnRjqVnn+ANDnMfrhx4r/K4
 3hRFB7Acur/sygu+qQtxnE2IQuJtdssijUBE7INs1BB2dMLixv313M/QJKhAtz6ZnjEQoSOZb
 VG3AZzvgLRl97oy0xHHjnkQh2lZNdmbc34Z2iT2UGmH5mUf7/tIcOck2rBglYfr9Jh/eaCLs1
 JTe/Onq/HmrxDSnktGhq6SgRPlkbM0zOOqyKa199iHZqU1nd87Wfjtyg+NMISEHumVxf/un3q
 1VpxO7A4YRzerRhNW6kkLBnQyH/SDu86g1F9dySeF8nbfn37kJw/KcO4ClCoK7PlWMyIVDIN7
 6+QHs0ewXgNhuiPTpel9VUh4ILBo8Y9RxG89VhBKqanUshg5A9fXriKbdwE+o+ocjGXfiE+0o
 x+my3hHYrS8I4G9PhnB2tdtZWj2C4ZXjyCrdfT9jmAsxj6jpMEIK3rRS1+wouydF/LUzB0y0r
 x5dsxnuBHlDlJw7EW9beATtP3TS23HDpiu9DuPxC7ZIsA+N8fu5izWB9r0+6ZvZHy80mLzwGW
 tw9IwvS5bFt7/YsCOHaucvyzmmNajXIObvmhAGZdvGjnMFjxxF6RISNbv60ISem/pJjapRj9W
 T4nRH0GzzE3XDknleuxZdiOyg3IePWqWYzmCczTXZc2JH2f6I342z7yll2/BKLb2cNdmcJX3I
 ZgpgRnqu7xlRFeNcDLVJ3z3of0WpKO4/e48m/3dYIILKM/o/q++xzUgUKbZAv29eIkTfJdFMv
 wR40qZD0GyAdDFO9mXlkf3OK27mgBGu9WyacTAEKNwuD93HJ9phSgH5beXd+alGrDokq2ayf6
 n3XdUrY8onAP5Ycb4mq78fcvBWnHTR6fuKZIsgwxP3oRKQzy0LTpsXpQnvfMO+r4iGx+NdQ8f
 75UBkex6ZCT2FtmbD0KGAhp+eCxggBD/cXkBMcXPWNX9G4OMvtlvHyoZRL/lF74Xm98gxd2Mt
 oht/DL2jA/51KriECLF3SzGCHrtK3jp9AjXXi29fPIMecAPNLobUTBLQX4k7zsHxBsS/wPygZ
 hpafoeRLslrrnqeu8bwWWGtmv8bKyOLdEjPI/qdW1cCO6JgfdfazSre2BW/hzqinM0DOJpcNz
 7R9rmrd3SBzJ2NzuDb5C18dOXZ5ljKue4qOO4vNjRtogfbyShSqSbYa5dpeHKzk16yp6jN/K9
 l1PnnIxCVyiFGCc8dx+J753APs5FOZzuQLGWNhs75T48yyDLo2jBvHnxqVID5fceKHy2qhWWt
 r/2ghqbkNxkCWVNcF8A88HpQLZeyv/BEu4QVO8+5RuMvFxaUtrDcmSIR3a3eLjIH2pxSBKX4y
 QqrCYqLjrDF6BIUG5//j25j9ENu+nge3VDyoXtqZhtCEMsgFirzcQQRa72Bt8fdDMDMXIXPq/
 8RHLxgphWHvazAcPkM7V0hPTtZZ/piXNynUtY4ISywKERcrvVewIOJnaQuZIgasBrov+RDyWb
 92bNb0VMZA=

Am 18.09.26 um 13:44 schrieb Krzysztof Kozlowski:
> On Thu, Sep 17, 2026 at 03:58:40PM +0200, Sander Speetjens wrote:
>> Add trickle-voltage-millivolt property for the Raspberry Pi 5 RTC.
> Why? Describe the hardware, the need, not the diff.
Is this something we can avoid by making this configurable via userspace=
=20
/ hw_clock --param-set=3Dparameter=3Dvalue ?
