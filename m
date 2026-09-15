Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0143947AC
	for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465956; cv=pass; b=HGpD4dijePja3bI0wciRGXE7EZRsMSrYQyiMLuoMwnRA+kUljS5KOjqbU3xRGE2ueVaYBTN5XD3rbW0B2DQ2VmIcjdOTgi6wB8TyLcHBptlSdqNRHj2g3FahZvNhp6sPEmiv5nwvxEsUrCCoaJjXI2aPRbX+7Rs8AoQ6dDPt0lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465956; c=relaxed/simple;
	bh=kleVDMYuhTqWHiiaz5/KA5UtIuEbfxUGgfD3WLraV3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9zesRHmZ8hqkkZbhbp+7NcpEN3Eh7hTf1cwCjRz+tLUTe1lcZPMzV8A9wj/avB3JLrNVqfIcPHjrIlykW4Z8rmsKPKYQddVZ62t1czyRvC+3qb9EL2n3qlAtEIBVLgT1wdC++u/OHA2coeyBWkwNFr5Cjzqk6QeeqazRNv6bHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPHwoVfS; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPHwoVfS"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so1677668f8f.3
        for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 02:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789465952; cv=none;
        d=google.com; s=arc-20260327;
        b=C9Zo4mT8aBDjcR6nxIqMzoFWHoPEc50O+m4kvcN2PhV2yCcknARiui3adOeuD/W4P3
         hFZKemzZxe2QJy20gJONASWhYolOTp7LxCWXgamyu2FkV8IxWo86dVetI9IpmoVi57wc
         KFePs3O0UadAdFAtTnEihrFIIfn7d33/MAXB0A4tXgzo9mr/i8AoY2dwshk9znV7a9zN
         8GPc2OymCF88OJTFz564xddH53tC3LF5JTW3VTFUy5Ik039p92TwYsOZRe96lSx6+CMb
         YpTIFYmwiSqu9nkFZXgv7e4rQzY7ldBQf/eagmU5/ENmSVxXuAWn8yAR0a8om1Ec3rTg
         WZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7X3JQQW/vVbBs4H3OBezc3yA2MPhISEc3UYAiHRMzJM=;
        fh=ug3vSuhRqrA66OI8VAQpkRba3Rk6GBf2TRNn6kHl4lc=;
        b=UR3dW/OVC0cUUg5w9StzPK/1leAjTHunYTs6N77z+y1xhem6RLsJipRUwGChWV15M9
         S3khPv2PsbmA62om/WMC1iKl3WX/WyblgwFhWXFpdqDHi2V5kbAQePwKL3+Gq6vbkaME
         lWGVIYQKydxHs6qgmHseduexH50uLStJ2mkmZx25s4dJ+Utm+aTxP4RhvQV/Rit/4iem
         c04a6y+8eBxTyzenp9wBpmPrY+WqNw0DwuWOq+BZ8vxBvxX3/uDS+yJv5jk+il7WzM62
         4gQt3B6Io5J0N1eSJwFPMQ04+sxelTKnV046Mt0zYIspoPNxKX8KMRhifXaevBf8T3S5
         L/mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465952; x=1790070752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7X3JQQW/vVbBs4H3OBezc3yA2MPhISEc3UYAiHRMzJM=;
        b=sPHwoVfSj6BrgKpTUBwM1697kYu/qdzziYZuV+NwHtu1yV9Vp03SMctKzXp2ctQF8P
         7xc+YG9n5AMGeXKzdJuoQkiKAmNB6RB6+pHdZ0zCNpBCa1kJvKGegivr5I5NKiTYNtCr
         Lallpn7NKmyxLdcYP4YuJUNY6NwWJwwVc7WpWgHvLvsrKO0eMyjYsJObA3OyIq0ds3IC
         BqjjgVQwgLMQZkCK6GPCFefeedGQut99o6hnDNxl4J0fFufJBRPwTKzfvKKBj+WGmpvF
         V5lpBsMfXbWI4edpdyVZNap4MZIeLxm/ImQxF+4gBtNyQy5b8HLdP0EYaLyF7Z4tUBMS
         GWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465952; x=1790070752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7X3JQQW/vVbBs4H3OBezc3yA2MPhISEc3UYAiHRMzJM=;
        b=19l/VmN/QAqBbFwM8JLKsUYyU+N1/yeHTmnNIavNBn6C2v800SVHYEKk1CSrDkSDAN
         SCbp9YNGi4Ug1eXZq7sNMoeonXlafsBotTvcwZR8JS9B9KTuydGHF3MMJcBm+3wQv2xQ
         S4TVDKX+bNmbvVaQ4NdSOkwg6OnDvyuYpHkLDXiOG16suM3gFa2b4pZ9VV6IPT/vfs2Y
         1kIap8kUOK9DByauu5wKb2/6ZqYPwQH7IZBTKZc3F5m5lITdPEBG66uQXVUpJ2ZlQ22i
         Olp1m9xwVZmqv5CdzzNwBymEXrdhFhXmgUHP4A/2RpIjfFkDKVe9k8KNfLz1fa/+Mjkv
         uRow==
X-Forwarded-Encrypted: i=1; AKwUvByfeF+rvn6DCHWnhONY0hw52ZK3diRZC3HuraftyH0phnzrPAno7V1gAU50TSTAqd9HiwcNdCJik7E=@vger.kernel.org
X-Gm-Message-State: AFuF++la9EbVY/1aND6erWQ2fPT2RAV2T5ZyjGbrblH8peZe3U5dTFnz
	tT4gZYoDosMSOU6rXfr9BR83jU6FGX4MGgbauFRmwMFagtSWIH0kpJ0F43DueNzaJzRIGJB4u8I
	m808i2Ux60RyCx7jYmT7wW8coplGb/URWRR4g+/9Rvw==
X-Gm-Gg: AYBFou0QMQtzuYfuWgqWBe3Y5nr4S9O/6yHfsidaCAMPX9kXUvCDxrbQlN1uXVOKbMr
	uMOEqappn3A5d9gYAFfBM/xdQ/uA/Aw3Ee1HOAfmT1ZsFiW/VUrnBb1NQJI1e+/KXd+WXRQhXA/
	tN8egDR52NDqluakAlJy7mFpDrLWlLBSg9V0L+dXen3sYk+IHIj2bQMkE0P1bEeLnlwP+XfhjV5
	5/L4hXXOwdSV/TsP5aq4df7LgQWlHlMG4wgVJUOnPFN3Oj3r9mVrq4RxYZpUgSVxJOpfaDjat0p
	HCL518aCY81NTk4K7hBpDe7/2r7ik0544PvM+umNrQdTrSmHfPgkzG4RZlS56wQAd0hhDNylY6S
	DzOHVeAaI3FbnTMgQhyweltsl4emuJaW7F9yQ/pq+
X-Received: by 2002:a05:6000:389:b0:486:f4ba:5c28 with SMTP id
 ffacd0b85a97d-487029dc93dmr8204463f8f.0.1789465951633; Tue, 15 Sep 2026
 02:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com> <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 15 Sep 2026 10:52:05 +0100
X-Gm-Features: AcwNN1XSbJVkpUo9ARDYe1mGA1CIhRKQ7l2yI92j0qY9QoJJt-n-SMe6w14_6bY
Message-ID: <CA+V-a8tvnq-D5YKKCXhk_OiN406u4+UumVK9P5uSEJjU7b=E+Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: rtc: rzn1: drop unneeded 'start-year'
 from example
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:19=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> We don't use 'start-year' in upstream DTs because the driver does the
> right thing by default, ranging from 2000 to 2099. So, drop it from the
> example, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index ea7b039a91e7..e96007981c34 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -91,5 +91,4 @@ examples:
>          clocks =3D <&sysctrl R9A06G032_HCLK_RTC>;
>          clock-names =3D "hclk";
>          power-domains =3D <&sysctrl>;
> -        start-year =3D <2000>;
>      };
> --
> 2.53.0
>
>
