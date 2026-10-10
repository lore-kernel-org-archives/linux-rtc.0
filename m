Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37790476CC2
	for <linux-rtc@vger.kernel.org>; Sat, 10 Oct 2026 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791630737; cv=pass; b=PZ0O4bdh1at7K5BP2vFQ50dzqeqrcnzdMIolgTWx5Iy8W6YuEjuo5RUi6YCnKkA83nM7lfs8V0ClLId8zyTqti+T3Kx/WylVaDI8aW2O2LCPVC/UIBW3Oa0MZFzhCEpJ3LghahhCBV7Zmubqnn69mKVbOdkWkLNqCx5dcR1Zjn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791630737; c=relaxed/simple;
	bh=md5oQoJphQol66QfbURRgT/HHzUasbyHUn6RkFFz5Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctaLuHBjK2Gg7tOAIlZWDiANHHIi52w/3FSjvv6nCwl7MOAT7RQuWB/lp0rg6jJ2MBdq4bp9/mDl7aAfWNfXSl4RurYzkuiIoBmUDg6M7ypbMwJrdT9MMqj07ZLY/ts5ViN5W3mxu8QuKCraQrwpVeb0yRE+Z0YxdnwKSGDLT5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b=jMQIHL3d; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b="jMQIHL3d"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c6f764f82so125467f8f.0
        for <linux-rtc@vger.kernel.org>; Sat, 10 Oct 2026 04:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791630731; cv=none;
        d=google.com; s=arc-20260327;
        b=fT7r+9hMS7hdjDgeJgbR2WSXj/kdNW2GkHUj59/0JKoxxw8XZ19dUfLc84sT3ZzoUf
         gAEVtt1NuzmwVR2aSk7L0X+L6CbU//fOWsKteF2wvSNqGCEvRi7dUSEiKkL0yt8kzkTb
         AqFhY/o2YC8JBdgEj9x3v6mfz8W74tLsq98STXzlvRJn0o7gah35EhzcTTnZUZCbG+Mf
         Ivwf9MKnHM4df0itAxy9czeztnspY/8Czjkm4Nhy6ZaiAQyGUksujby+jQyAmwWQVRQn
         TnRWmCGSZvlf0CIXj+mC2UYOjxB49cRZ60rYP4QPBe0TiaXwEWMcfdEmSinZUHplK5Is
         ZcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iYyP1LxibJML28p8CbELojx4hp1/pLAXT4X+K0jWjU=;
        fh=qGgKSSK9Qtf/ett272j4yaVUKB2kcJjZjdRH7wWQz8o=;
        b=Ya5Gsh9Fv8NJWyg2qh6CM3zuE8jGS9IicR58Ep8k+DKNoI+TyeXz/zq6K25UfVe08h
         sC0zbZOEBwPRG43ORf4Db8jrT9K4koM10KuuzVwcNZZdwe4op8ifEtMaTPRqmyuTxybG
         S2vAVxmqqd7KL3D8O1hkPgq61H0cNUdwuF/ieDFu1UHW3conFQstvvFIxLZCDlZYo1gz
         RuiS9csm+j/xOHl/dnUTLi6EW4dFyxNV/nRAtGxrwgBhIZBihuPrAJ7j4/TY8pLi02co
         uEurjA/pPazG2zEhykXeIUWnGNeLVZnbZ+90Fy5YMp1E0FUaTouuGISdJOHg8B5w+ktu
         YlsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1791630731; x=1792235531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iYyP1LxibJML28p8CbELojx4hp1/pLAXT4X+K0jWjU=;
        b=jMQIHL3d/ahvcQ6BsHBNrBAF4nYP56SS9YAm4AmPAFL6DmFkjmZnSgHRE2wt7fYiuP
         T3Xctl/ZSBF+2OyFt9KabgQYzHTNrD20cU6R2CETxh5n9y2PU/JFM0A6ZfF+4qTYfDPi
         rHx6C1aY0AMRP4Th1ZHJwsOnP+otfYFKvLgHPL33eXl9wsBgF7S/r+HGKU+4PFN/aCdK
         6+gAwKsABnZIBooJvK60M1rr0YbKcjrGWmgqXC5XpEAUX7Sfu5yGH1GGdcEyRAlSlhgh
         Z4HAwuETuRxBWurYXbr/m9CsFGXTvgrdU/5BbYm8RhxUN1kzHB9MmSQpjzx0/tR3/8nu
         LlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791630731; x=1792235531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iYyP1LxibJML28p8CbELojx4hp1/pLAXT4X+K0jWjU=;
        b=j4oFG0pzPWxQPLnTyxgv8HTGxnfz9GCMypCWa5Wv7zGFeLYQRTnk+ctrZZFnSsenE6
         bmhHBHwsS2a81PsqrwbVMe/K8Anp4LTLlYBJMKpQWurDSYOiVozwwaDVxTJOVJkVGoGb
         5RurNAfPBfn+dghzE2uoHyGQJZotNSuZ5XdKArsM6vt62j4bTvPamOCgoBl/yx7gt3c+
         ML2WOnodO95pD37MNyuwNN3AuL4Zd6tsEkykq2xbSEyF3W+4270YASMsbCyfx2kCfigQ
         NOiuNAAMNc4Z1POgoGkC4uhsjnTRntSsCycXQXH0gulrcw2G63Rb/+lDW3a2LjvGjXiz
         fTvg==
X-Forwarded-Encrypted: i=1; AKwUvBw+TsCFC4vvfJYikYRPBblRTsHdh7MoNnmNLSiQJuETzjcV177iGMn+96gbMnWJmnmzoJCi9nC/AUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLhz4GAePPXhGpov0CW5kgUVh280eJLyBmGtsttvkSgFz4DCmU
	2rmrtMP6OyLuwj6LWpSJ71mcMLYl5zbmhrNmIDK6vQaSBCVybdAy9YmdHHgJcxF1NNMSzRV5G3P
	K4cR/Ind64wYmNGKHQNEJPZ35YEByPuQ3A92q7Wh8TCvHoxKTNR6ELb+opR9+
X-Gm-Gg: AYBFou0JMhCBhEDsm0uFMWTq93NvXSHpXJQL0gF+L4qknME6lERv/9JbzK3WmJrcBoF
	4Pe8YSZNkGJhgt2Ukwo/bvS2Yy2jNuGQ4+4DgDi0losiR5bocjcXsvH3F8Qy+vw6BmxSwxbl/Dg
	Q3b9pAf2lj0mdDi9EBD8n2JLzgKxeYgayeUeoLk5/RFGjVACEOsUzT400wlcucdVLh9CSZxTrsw
	LkB/onRsoE6rOOmOmvhkiulI6bE7Zjo3Hti9HU+5JhAHxeFMNcVnBjrjAsP6/fbyHocwfkcLq7b
	XW8ERIr9Xl9xLU4w/tGeH+2PMA246K0hh0Si/NpSGjtJoe33WEf6x3xAu6WNbV0iFw==
X-Received: by 2002:a5d:5291:0:b0:486:f3db:e0f2 with SMTP id
 ffacd0b85a97d-48dbaade0b3mr6036971f8f.14.1791630731034; Sat, 10 Oct 2026
 04:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sat, 10 Oct 2026 20:11:43 +0900
X-Gm-Features: AclHuK-PSyRsX8cggYxKA7ZFI2xxYlvObXFkyui2LHRAXrkPEmOXGux92QpuC2w
Message-ID: <CABMQnV+U1xFSctKwkUkjriJwarD6QwGJi5tzQTerrK5Rio7e8A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2026=E5=B9=B410=E6=9C=889=E6=97=A5(=E9=87=91) 5:20 Wolfram Sang <wsa+renesa=
s@sang-engineering.com>:
>
> The RTC on R-Car X5H does have a reset unlike the other versions.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Passes both DT checks. Kind of fixes 3b3fdc9fd40d ("dt-bindings: rtc:
> rzn1: add R-Car X5H support") in -next, but we don't use Fixes: for
> bindings, or?
>
>  .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6
