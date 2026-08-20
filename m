Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665A396B98
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251360; cv=pass; b=PYKlMJGYcCuUHwVJZQ16SXbSnD+2wIQ9AoLNpaxOsjqRnuw9Hq0kh1tQtE7YEA9IIjLiLBOGaQgwAugithJ8NxzCFS6zPMqDIoPaJgzB0pBSaHZD50Tb89oTAOBO5GH3zj0ncfN46Q4q0INHUP7WGaFXUHUdODFq86GJQcMHRK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251360; c=relaxed/simple;
	bh=60Gy80AqDCDF922FU4MPaATM1vUz9hD66trB84dzQvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJapYY8Xe9OypFrvzQQ0WwL9yfcFOaXEkv/95h/OguGYETV28lMcP2C/40KW+t8Nkkl3ti1cNgFWyOafWL1tJQM4VX6zUz7PBV5MuxIgcuYeFm6ECiHg7IjeQ9wozQSXnklTmcqRIDqyGUeVYBMUveV0woD0vHOUA3vzYKq2V+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHg0bXf6; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHg0bXf6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so514655e9.1
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251357; cv=none;
        d=google.com; s=arc-20260327;
        b=HEs6EkjnmJZL0AldUG7jKVRVFlgTD/rZZjls8860qqLR2qDdYQzop4OOqyyio7S1Sm
         wZ89mQi08dszHb69DrkUlYdZVVwhMo9xwt4cWGhd3GVdqEF5aAXBaEXrNfE7KUmw/UYO
         sAPBzaiKD8ZIVizmxifDDfD5pd2Gah7wRPLR/5TsGnK6wj1XM41z3KH5dP7xEtX3xqc9
         pi2ZW0NFUiXEawD12sRzIQ6CI1K7U0JIHWYrtQTUwBa0z5ycpyaex5xGXKkddg46dubc
         86VQPRGTTKhIVO9bhhafnruZieh6dFP9BoPLCi7VxYOTL7PMnKn64qe07u2SPTsaiDZG
         vPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vFqOYk3/urySuBJFd4x7IjPcpec6+kX2wN+yqUz6ICg=;
        fh=ECaNb4Ppisy6B3kQVM40ronY3vdJZMXo75XLYaMDczY=;
        b=TUP2UvSfZ1Vp+unetcBpR9zqQjlniOTrdxpsyYhm77+c02zejdmBjHgvuh1QlWrkO6
         +FHN1aTU8/BYKBdp/vJUbwGNWTmiozwpSgSCjA68f7iEPfH4/Pj9QESlX1/l1nZMwam1
         Id71c7PGlTWEhGLwsjBcEOWbrkLb8OB29ZsdoPNeAqm/klojD3m5kecIhEs5MSezE/Zs
         mRFGYrmF77LS4c7sF/kYp1ocwxyWKChv02KZapftXFpi9UCIv7hU3/vVpcuJnONl21Zp
         xdaG032M7xcKuDVDu1WVe8ItDr7llsi24Urv5q2pl18n8DSdOYqWDANOFiNOlaMlF4R5
         mSsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251357; x=1787856157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vFqOYk3/urySuBJFd4x7IjPcpec6+kX2wN+yqUz6ICg=;
        b=MHg0bXf6ov77SfAhQcjwPP+2cN+kEIUCvFuKF7tA/NqBPaiY2y0gsHF1cO9MU5IzzG
         1b7i7TpVl9MYWedORqC1ktIen4H6GB3gTehwobXvrBiCMvt398aE1Xelp7btCPP+Us7c
         gPyRp6KYHIBxzAulqUqTpoNO3yqFSzIQdoLlGSm94El+0IX9l0y72I1fBYYQ2FiFI5U9
         duiu37kc5vnyUfcnbl0MQiFwoo8JKoqi0Pux5HW21zi1YnViRGbF/dwpUd5nf5O7pvoN
         w4SIULmfVIxR38OJcg1UtJ5DNDg1XCY83mfrGRSzt3YzU/vmoTi+4AwvAdFKK/j4J90y
         pZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251357; x=1787856157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFqOYk3/urySuBJFd4x7IjPcpec6+kX2wN+yqUz6ICg=;
        b=mkYAAPzJ8vLplq6xMG1esJiBTLbRkOYuewa5ILdRo55xlSBKomOCfkSqRxmQ8Cnn1r
         tuiw9FbUQSZr4QU/gDQQEgChcni/BOaxRpIiZX9zrZSq82nyRKeARIkTWVqRKrZi/2of
         FoyHaKiWJkmqx2Tu08k+u2y4pMKwoqyWYXkAnfoBOr6etb8RTyTFsRcUp6kh4gPw/qle
         lOBZMjRoxmWCKD+O0WFtZ6mUjZ8PXC2wXwryWC1Nk/hzKiXVnC3NoialynZwTtuezBKX
         FeO6ycNX0wQgPO7sckccMM+gFOIy7DfxpoIucFqKVdwk5pd7Nm2dRVjhOsYWA5+udNoL
         /CbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0smyL2Wdiqyvk4A1L6nytuuBEUYD/eRCmBdBBL+d91qXn308zKmP7b8xeUyeBLVo5zO7p/AHmeHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxDrjHS4mWhdBrCkKKCLsHsuBFLHQDDBqjYXCae//sV1u32UM
	gF+ZD68F/bZ+SP3zOc+PdmuVGsSH4L/eq2I44SSJvcMeH8bp7FVyRgp7J1wMbiLuuX4SiElXdAI
	/qlAqfsE6Vtc71equiLHZvKqeo6eMIo0=
X-Gm-Gg: AR+sD11SBE4IZsXBsXx/O1oQhad8Xlze4gbpx8w2WTdtG//DF+4uJzH1DTpt8FjR11m
	TAFFIvCuSd2IwwMTaTEq/i43f/t+5HFwoeCEWCJQWI+9MqORzPvV6HxlQdEUNzxQlcdDJn5OfTb
	6LW+IAJBvoat2N+St4PQb0QhTn0z8MVY9cXt7RAZ8aB+RCgqQCf0Uior++mGbf0/65XfN7UWnHQ
	/0ok3kWWROkMFkFuDrt1KK9zww4Ag38fPTt7jGa+O0XsCZqTppBfXU/XIJICm8BCFZu4xJEVKdP
	hz76XLlTOzaOFATrfgq0+1gH7875j5ULzh/juT3uz8ouK2uzS4ky+WocxkcG8a2uMIoXbX03d7I
	OALEYyuRC4C0ecUcLOzWtg7si3PFqqeJxM6T/G4omvak7Xw==
X-Received: by 2002:a05:600c:a102:b0:499:b81d:f580 with SMTP id
 5b1f17b1804b1-499b81df6a4mr20364505e9.2.1787251356632; Thu, 20 Aug 2026
 11:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105028.70F3A1F00A3A@smtp.kernel.org> <aoWqIxFRItjNu6uN@shikoro>
In-Reply-To: <aoWqIxFRItjNu6uN@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 19:42:09 +0100
X-Gm-Features: AcwNN1V8xZnCN6jYwc1rWmadht_y4_htRRVcU3U6J7W20ZY6lIODI2Uy1wnE-ec
Message-ID: <CA+V-a8vuA5EnPP8iCsCi2e3HY-qO6iNs=1bP-NnfQMDrrQK0vQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-rtc@vger.kernel.org, robh@kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 2:05=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > [Severity: High]
> > This is a pre-existing issue, but can this sequence of register writes
> > trigger a spurious interrupt?
>
> I think this is true.
>
Agreed, I will add a patch to disable the interrupts before
programming the ALx registers.

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 44e8db466cb7..09631a3a5134 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -280,6 +280,11 @@ static int rzn1_rtc_set_alarm(struct device *dev,
struct rtc_wkalrm *alrm)
        if (alarm > farest)
                return -ERANGE;

+       /* Disable alarm interrupts before reprogramming the alarm. */
+       ret =3D rzn1_rtc_alarm_irq_enable(dev, 0);
+       if (ret)
+               return ret;
+
        writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
        writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
        writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);

Cheers,
Prabhakar
