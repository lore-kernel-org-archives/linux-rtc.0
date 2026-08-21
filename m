Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788104137BD
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298738; cv=pass; b=pZXNPW4SWamv5eo0me7WNTI6YFS7nh53NI3DJ+XfWykN7iBd8UQSUxhSWIFEbmuLK2f7tQlJBd8lS5SYYUQ8IO842eAzwg2k2PvcQggOJKFsMiX06Tk9CR7wzEzA7E/6NezC2JYgZEvqmw2h6WCAkQc79T6prqAgbCaGkZVdyOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298738; c=relaxed/simple;
	bh=iCkxqhNZxgEtFomtEu7YxBIX5x1KY9BNtJroquO1XxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic4CD7E/RAkcJ3Xh3V41rSPD6PGa/VcwA5UBaxPXDbE0EFCcjxCgo5or6jIFj7ZlhIp9laSUSdGksTFCmbtMQlvkz0lEABauFoOmVXs/dCcrtINNLJvo1Pm6lArjET3+g4gniTWeSzfrDJfm2fqQQnTHnbw66FXzZl0AVVlh/aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmaYIegP; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmaYIegP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso253854f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 00:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787298735; cv=none;
        d=google.com; s=arc-20260327;
        b=B4cZVCclItUbMgmtYcFYoqZn27wsrUwq67v7gRzPTR7ztGY0nfy0p7NkQVjL6kldHJ
         gL4S/aN7QQA9Rtah6QnPlinS9+hJNGjLf+cBA/ppaN2WLm0lT37MftrAHt83M9Yd9sWf
         tfL3Czl3xf7uiiNFVVZxAcBzSQXTJsGZXPlKcJzxeX67NfCkpaG/DQsq1mG5hxGqYeYd
         KBuhinU/AF5lLdUfMNLUNW68ha/hq+83nJvGfSHORWzIeJ99rauSP05O6CwwFfVIZvyM
         wCFgwMMT8ELBiqtpnHARqVvEQW7lwFZh7Zv8/iXcsWJK5+6oTmicnI/dXRUnxRDkVuvE
         SJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXVNR4kHchxo+dOC1K7o47R8p3Nbe2lAn3hnL/xdjqw=;
        fh=HVTuxqztHFMGlnmIb85297CEgRLQn/hJ5hBnmss7oNY=;
        b=mKBocFkikeUWYSLDE8h3ROdf0VDuZWB6kNubAWBr5ZH3cWhnq1OA8jo0VygRwznHc3
         cGKdbCbFjosfnMyYqFs3qqY4teAXnJAOPxyd5lIUj7PkXBMWj//CQ0juPuKyqQVURKpD
         5zJbdtlU2XObUZ5uhqSNBCOECDkz11o5YQ3UlCm87zjbbPrKydM3Tls7fKgKAhe+Fc6N
         DLYoKIP8hA9ZSNKQppau/OzxKL2ZJMT2CAiqc6t+HVDLWJyiH8Io2VeVYT28s8VVt8An
         +IrZ+CjVkFTyIE6MihHLmNaiL6S6ahUNg9Q9QNexjbCHH0Xc0sFw+dHrAAcvQ+CUNw67
         +3uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298735; x=1787903535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXVNR4kHchxo+dOC1K7o47R8p3Nbe2lAn3hnL/xdjqw=;
        b=SmaYIegPGvowGAWTdIAVIQyyixhEpKqghPDCzlHFKWV+OLmkyg2JBGoIMOW0FDPH+S
         8hMX6EDqZJZqJsW8daZUL1d7yFVP6Qf4rLRmyBYj2y+5LK6Ie5HOi6Bg0X/J1kzIB3vJ
         8p3a79EozxMPxbFrfpSktMYnPtFbO48MKqT/XsUopwsVuHnJyJbbZgHXxQf6+rG3n8VR
         x5GykVVoRatG+Id5LeKS2g3jC8Cj5dHePa0uCk28ckFydh2UIbAuYLtZoLkSD/D6EopN
         gDvu+SRgfuXTAhxzOasZq3AzvNhieww0bEKpaSXwOIP1taFwEoAUMoCEjFUY6vdpRl/X
         ZkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298735; x=1787903535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXVNR4kHchxo+dOC1K7o47R8p3Nbe2lAn3hnL/xdjqw=;
        b=UyKVO/J1/ra8FH1Wguy3mBxvCwxcjY0PRMB/LyWw9hYgcRYtg8C4B8HCPnNxbZDhcu
         peTRbbOTV1txopLN0sHKgUuFibiAZ8PYwHMqW98UUcE/AzOANuJeUvD2X+Fj8w/awPqw
         zahIt/OUQo+KeRKY9Dz9zoNsxv+k+6v98XbdT0rz6ymgWge8OM7QUH4+yyEBvfjZk2nI
         TS292bEWDjn2sGAEEPpmGj3A1KfA28hBWrYYrSOHBq85drVXb3elcx2ohFcxL0ZqG+X9
         ngXjAGFnU2z0Cd5VHNhW0QC01NI/12Jkfv7EuTBRmwN9kS4Mzy92ce3m9cwhB2MimrMO
         /ysw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0GTO0UW0/jYMefongwSALEr4Z2FD0eTK4WW/IoVnbbyxTqQ+Jc5mfdVsixrhskA/r5/D+linxN2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lhg77LUFwggxrwWENGxLXln+v8E/5XWwRuiejwNyFkJaWRL/8/
	q0gsGVg3yUki/f90nnp2cSFa9EpeH3vSwUtGuTPQWE7u1bAS+g8y+zMOZRgHRtvG3HH05dELf+W
	DMeCSLVzRkeapkqcup+huo0FCMo6wkqE=
X-Gm-Gg: AR+sD11kt5mHGlolUnfgJc/uTok6vEXchie0uZDgYhkwwLtdNnU/5fpQS/4eYxiOaFy
	vYI2imZxqf0Opu/cUh3JrcCS/WczLKyAo5/2adQgeyr7M+x6HzREj+4lmldjmokijKN5XfGLrdj
	EdEXQT5H9DDt9GDGC8ao1aonhLwkRBlpcJIynSym5ihyIbsHka2tRHVESKhOzAoBUONZsl1iH9K
	acFtQMGauL9sTkmyimd+VWHwVUyEv9x3u/RDXdgrco1UwTiRjRELP2Trtmv9XAHmpOrpCngPhit
	n84SwrAXzmlxQJrFHcS2ox77+mcOTQ2tLrPV0KvJdM0+lu7hqNw2CBvKjqS3o2lhnEGQOgl4r5w
	KvsWg6wzleaj92NUCsFIFu77TeTuqSchRtsg=
X-Received: by 2002:a5d:5886:0:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-482c0b4207emr6296886f8f.5.1787298734749; Fri, 21 Aug 2026
 00:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com> <aoWr0gfN6sQmgUie@shikoro>
In-Reply-To: <aoWr0gfN6sQmgUie@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 08:51:48 +0100
X-Gm-Features: AcwNN1XlRNqpAUbeTUrYnSgdpHgWqQlabT6nhqi5ctC444iuectwmXZSSzZ0vF0
Message-ID: <CA+V-a8vwNHm+KZs74ktpuvxKjOcqLtcxGRFi8i-_g9jcPs_3yQ@mail.gmail.com>
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

Thank you for the review.

On Wed, Aug 19, 2026 at 2:12=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > +     if (!scmp_val && !data->has_subu)
> > +             return -EOPNOTSUPP;
>
> I'd think here a helpful comment for the user is justified. Maybe "No
> valid XTAL provided and SUBU mode not supported"?
>
Ok I will add a dev_err_probe().

> > +static const struct rzn1_rtc_data rzn1_data =3D {
> > +     .has_subu =3D true,
> > +};
>
> 'rzn1_data' is maybe too generic? rzn1_rtc_rzn1_data? Yeah, looks a bit
> weird but I personally still like it better.
>
Ok I will rename this to rzn1_rtc_rzn1_data.

Cheers,
Prabhakar
