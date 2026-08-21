Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F14391E43
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310390; cv=pass; b=chpsndLXY0vnQasXDnR+lviZDhAF+0eWV5LZqJEPgthVPh5ArFPNitCmUciCkyws1qL/TJwnpifoZbx5Gc0mNnkIWm1xG7Aw4BxhQOLRAoG8fCmqU6RiJBApes2TfH0GoriRA3QZuu5mY5k7p+GQBswQHxigomX/Y3K8xN3AjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310390; c=relaxed/simple;
	bh=KrZ6HeRxc2ZB4KNjY9rusjhD8xWXy4q4jVkQHO73EgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFEGxA8h1nzGU4Nx8GH6wiSogLh0nXVnKGYsDW7fFsGFgO99n+SUbQUqwi9uamGN5W2Mjr+j1noks9W6maDxmguuibR8G9oex6M3R6f6CNiKSCRrxJS2+++t3PrUue27sfitPZSDuGnehTyBIh5LUJVpzDp2X97q7Wjzra14Wks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8m9tW3n; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8m9tW3n"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe89fb333so456330f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 04:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787310387; cv=none;
        d=google.com; s=arc-20260327;
        b=APKUjxrlU5/XwdwA2b9jRkbqUnZGUN+xb+xVrhrNFVnZFd/GvWFYPBUSRvH7hzSB2D
         TS/f5uHoG3Xc6DNYL9b9mrUz6te/AOrWG5UXP+ElwTXggrXzId/8afrJJFZFdSrMF0BR
         y1TWSjtTIov1VWw5thdWtWX7MLkQKX8LxvhBLdExIYRueeW7LWlMP2IAiCaXLB9E1UGa
         CzuoNB1L+5C8sgoF1p38D7A714PUAUOXLzjMTNCHgOLflZvOMGve0bXSoR79qC+4U9H0
         k5ajgAbEmmAnhbMLVSOsetsPoBzOKRqaPdTeJIPZita8PiZmBUu+ZbKEUV5ObrG5lg0O
         IJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HoJf6c72cR7dmFL5Gn6KP1hZaz/7qfGbBe5YOvKHjgs=;
        fh=TPpGYnttC8LEhM05mkrw2rFI6Vln+6YpXrKKu2Hi7Ac=;
        b=Ss7vLpKaWB3q0V0Cu/ktPLOz6Tx2G5+menQijBlFpKps8gFyg+fhg+VUEpRNDARMmB
         yC2yK0FKjY/JLBywtwoSYjy/NNZmnz6Y6Kso+n89ageDvgXzgYPJ37JKy8aKgDVdtKhr
         0zlihNQ9+czyfY9PVs3n7yNfNIVUiUPSw+oJn/qXpOduwcJeeqrPUb3DcDUTNY/X9sQS
         iL0jQ+rAZXqbYUixrX7+H2dCrBJf1L4Wb4LIWQbwMzfRMZVpjwvdL8KooZSXgh4tbLNB
         unD3HavxNWldOBMSZ2uy8V6Ft8DSTElmHn1pvRgcKSe5TJYOPXq1smIaWRAY63MNXNxT
         adHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787310387; x=1787915187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HoJf6c72cR7dmFL5Gn6KP1hZaz/7qfGbBe5YOvKHjgs=;
        b=d8m9tW3nM+Y1r60sS8EOkeQyEfpz8DPciym6BDPezegSU6e0mqaGGtRR2x6mo47JYk
         H4lGR2kQ1TLKnj2Ky+2vB6Ni/DQ+JhAnzTrfaso/VJXOzFbqmug7IxBow8wVyqWfSA58
         eKE25VmYC2wSUWbGWbsKIIxli/pUwCwjN+TM27hxE7KhDog61lgaX7Brt5qIAZ/BNBZB
         vkQ1FoLxSskQcr+IwnQ1v9OYXTAyk4RjaAi7CA39LqoNDYfGB/+FdZHfQE9CZ4QdXIG1
         VKNe5sagm1UUcoDJqYUfkDI5KfYkU1RGCRdbpRUaW8eDHg+HlmmBMwY9wjVag0kckKvy
         p9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310387; x=1787915187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoJf6c72cR7dmFL5Gn6KP1hZaz/7qfGbBe5YOvKHjgs=;
        b=bFCSLaXLPh9M/mMD/Iy0DOHeHTP5Et0DjFvOMQsF0itXBcX4mGOZ9MsAUdMtHT4vca
         wnzVNjazTNccaCSOeTQ4p93r7C2YnVhPFDY4zH1+BWvXvPVkg4eDx27pKPezgNoaOide
         V93iDMBdGjg8rb9bflOXLR0PrZVLYbQJA5KMvtkKs2YxG9emuNgtIzkaXvBrWP0nPcyy
         xP4gBfvYzgU6n75VTTx41yBfRLJoxLEnrngrZnlOh5MziYo7e9i2DcFDxD773FLadFwb
         NRmbbbJ/bWQ7axeISdmdvU2nr4l7qfrirldJ6mthXlLMVsM9ITA+2seHI+iHFNvU9t8I
         aHCw==
X-Forwarded-Encrypted: i=1; AHgh+RqSXhF0p3aUpwbiXW7b5WR6OJ/Jbusy9pYuF1kcIuJXXAIbkPWEKbpWObcmj7RNxQmUYuagoSsUIfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mxnU73dLCQtXd64HQE5olqYA9HfCVokeKv5Xgrd3ImFGBGGAou
	29Cdb+RgljWEoPwavbABKbjXVQR+byNgdtW+9bTajgZfvtzLFg3IHMj2NRzpFjWU4tripfC+PWP
	sJIwKKi57Obdz3ke0Ar1tLqAhfrusA6I=
X-Gm-Gg: AR+sD13O1Ci3IKq798w0gQA3xaxwPYmF7EK6KGTdehRwu5sv6YhVYJ8SfU9rffFcPZl
	NBjsSNOVTZvmW0Mj2gIb2Tox+1NCGacOg3X7GlBnzaLS0n1+mKdfJ1OMNXuuZt8tUxOUXXRdwR7
	CHy5GdEcV+QIK+31DGr0ch4HCD7DxLzdZ3Z1GVWrPKth2kPE71ejczbd2r8Cnk6nfCw19Ivsbfm
	DHHSD7/QGHB/gI13UO4DsAd/fNBkszCRAbWSgrGA0YG7jN/ScRSShtL9eoRABxtMmBaEvZoCdmX
	ijqFE8bQTDmI/zAL3MzR5OnRntn9+f5UhlIRm5yPJ7+vq29ut8lrb6BYAbJ4q5SpISRPdX9qR3Y
	nw5K15ZsscC5PRBNy0FPkLIuu5kl1YeFMrjg=
X-Received: by 2002:a05:6000:41e5:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-482c0b5bf92mr8558786f8f.8.1787310386687; Fri, 21 Aug 2026
 04:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aobjCr7ZtpLmL3VP@ninjato> <CA+V-a8tpo2Rc9xsvsj9LLqD2ZjoHzRAVsox=7xURAtwA-GYVEw@mail.gmail.com>
 <aogbk-moFmTTFkJ0@shikoro>
In-Reply-To: <aogbk-moFmTTFkJ0@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 12:06:00 +0100
X-Gm-Features: AcwNN1UGmz1uUQCIu-LKe-mxUq6Df2QcPbc9ZZ1iJn0ahM-r4uBoryBwB3wI0p4
Message-ID: <CA+V-a8txC5U_VvXBYnMXctBg2Jz3a44NZjn-P39amUq5HihG+A@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, Aug 21, 2026 at 10:34=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > } else if (!data->has_subu) {
> >         return dev_err_probe(dev, -EOPNOTSUPP,
> >                              "No valid XTAL provided and SUBU mode not
>
> Yeah, looks good to me. It is maybe a bit hidden that xtal =3D=3D NULL in
> the above case. I wonder if adding a comment above the return command
>
>         /* xtal is NULL here */
>
> will help understanding? But I'll leave it to you.
>
Sure, I will add a comment.

Cheers,
Prabhakar
