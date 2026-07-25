Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8762FFF9D
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007266; cv=none; b=B9pwlLRz+03HLsC4/IEX54kx2BK6w4VgmnQRGqzqxeDrMCRcrXtTedw1mRDeA39qnWm63iSXisX/cqMiVf7s5RWcq7mdudypGW8wUsTaD2kvMmrOxsO2A9hVS6Y3IXqVjft0shx3oCT0kyzZeE7uWCeyzSfbuF9rkA4myPLKuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007266; c=relaxed/simple;
	bh=bbXKsLmsWgE5qcfQH6W3dtcu7Nl3Mn1hAuZTK1MZ9JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB7azZxwts7sJUYE5mEpvO882UeqpMn9US0gcJQkwk5UCk8nE50F9N739cH918ptC7fSwmtwNaBf7ouwyhk+Nf4PvCt2CSMo3WZFA6cA/OTde4CX+G4eCA/hT8z//lywzycbFEF6GTcv3XYMLoZUoKOOCkhmooUxFK4pp7fEbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj0/w/RQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj0/w/RQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so11222155e9.1
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785007262; x=1785612062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BGq1MYuzS+pjKAqXa5uKrnlzlVFHDeU8OLo2EF6piLs=;
        b=fj0/w/RQ//N/B6UvsHwYlD2aDOL05Vlw8YO0L/nIkfgecUZiA/tJgKBwqpi46caBnl
         vOETKUghK3o5Un/rkn4Bd/ve9vyW9OvJUtPTCJ8OzJ7i4vOEwU6NJWytMd/aCHINCEPC
         xDQVZwjqsnPY7ORSmXs+XkGVe5c+6F7Cg31d1xLI8K/Wj6XvsTfZvp7ura6HFZFNdvLQ
         c+HtqOK9kmO5cwiYeO3CoM7X2rIPwL+5Z2Dpja48frlpGwGCnJrQ5gljVBnmOMFVj+xg
         WkiKgN4IhUJXeKMuIJa8hbf19nE2YcpQuiAM1WzaOMkFaOq2K9R1EoegsobdQs3oardO
         0zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785007262; x=1785612062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BGq1MYuzS+pjKAqXa5uKrnlzlVFHDeU8OLo2EF6piLs=;
        b=pe3gdVGEfn7gPDMAdzAkBSUTr0T/QEHPt216Nodyg3U5jyU6QC2ov081SrKAZfx6mK
         /X+mb75FGN65RIjcbme5cm03B0EzkbO2Im/viPQbxWDrHeQfNjpzWA/CToEbUBJnzRXt
         id4meuC6hbKqgY/eWx8K3p1h8I33gzFTeVqgJsG5//xJeGEhwUQvUsDEFEoqDbj5D6xU
         dEtvr1OMAX1Q+D6SVcwnNOPVXB2tBDREgDioldSPqAGgY+RjYClTiOcbwgo/nusjqf6x
         K/wxKQxfasJxc0lovVjrCrNTcdr9UAO/HYFxYD0K13+ABojnip4nLEAFlsU2sWDnQk41
         1eeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7PbkLuc8tTfTmFKIjKSlZykdJVIHQw4tXKzOs4Pn654hwEgoMJdD3G+BagDcmvRi+f2uC3SPAcrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8p0+Kq/yPlKQMBi87lm9EmPvVqCG3VMUg5a6Baq6i/XMc6nPh
	L10ByI4jhJ0CejieH0djvNcXr8BuTJZ0LCMjjOWvtnvbzJFK4+oKHO0D
X-Gm-Gg: AR+sD10PfYSGQBNfx46MooFgFhwx6Qb57CkCAwpnXZ2ZqRxB4BTUCW0YG1iNWPCouOa
	ksG6KwyM3XngcEonO3OA/656g6WfaQazXmG2sVB0+6+ATFoCS5LVDH1klvOx+nqrBQxdb9CGmm2
	ocnZ7XmJFMEFQQ8q3oKlO5rqbFmeLSCMxNuZxnjh/DbSGpxqZoQOCnVkfQhdI/ihUUoiGPyAzYo
	cL0fqaBWTI5VsDf/S9X6OIzYEbF5tpHWtcu1Dl53YU1qU6iKJ8DzYem3taJqPRBVGaAxGcQUP+h
	U+i+o3L8PvO9NsGVdaVLxlvgPDFclDTCUlyNxWDlPEKmil3So76usCoi05EFqwGg2k81jStkwD8
	O4ZpicoJECJwAYrpR1Gd/aKvity+4mAJCsCMKVyQzECDhvXjrxd8VuzXEoqJV2+N4cnVAOkC/ke
	tmIA==
X-Received: by 2002:a05:600c:5487:b0:495:7287:293f with SMTP id 5b1f17b1804b1-496b690a85dmr29215635e9.35.1785007261955;
        Sat, 25 Jul 2026 12:21:01 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49b2ffdsm86513875e9.15.2026.07.25.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 12:21:01 -0700 (PDT)
Date: Sat, 25 Jul 2026 21:19:36 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	robh@kernel.org
Subject: Re: [PATCH v2 2/8] rtc: abx80x: move part autodetection before
 RV1805 configuration
Message-ID: <amUI6JY3BFTrbdqp@antoniarch>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-3-apokusinski01@gmail.com>
 <20260725150753.325271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260725150753.325271F000E9@smtp.kernel.org>

On Sat, Jul 25, 2026 at 03:07:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch fails to resolve the issue it describes because part autodetection for the RV1805 incorrectly resolves to AB1805.
> --
> 
> --- Patch [2]: [PATCH v2 2/8] rtc: abx80x: move part autodetection before RV1805 configuration ---
> commit e37ea6c1257442ff3423e6bacb742916beb85bbb
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: move part autodetection before RV1805 configuration
> 
> This commit moves the part autodetection logic before the RV1805
> configuration block. The intention is to ensure the RV1805 specifics are
> applied even when the driver is bound using a generic compatible string.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 5486d9d0b1e5d..ca3af91c29977 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> > @@ -814,6 +814,25 @@ static int abx80x_probe(struct i2c_client *client)
> >  		return -EIO;
> >  	}
> >  
> > +	/* part autodetection */
> > +	if (part == ABX80X) {
> > +		for (i = 0; abx80x_caps[i].pn; i++)
> > +			if (partnumber == abx80x_caps[i].pn)
> > +				break;
> 
> [Severity: Medium]
> Does this code introduce a regression by preventing the RV1805 configuration
> from running during autodetection?
> 
> Since AB1805 and RV1805 share the same part number (0x1805), and AB1805
> appears earlier in the abx80x_caps array, it appears this loop will always
> match AB1805 first.
> 
> If the driver is bound using the generic abracon,abx80x compatible string,
> part will be set to AB1805 instead of RV1805.
> 
Ok so I missed the fact that "AB1805 and RV1805 share the same part number".
Hence, I see no way to make the driver run the RV1805 configuration when
it is bound using the generic ABX80X, because it may happen that the
detected part is RV1805 even though the real one is AB1805 or the
reverse (depending on the order that we define in `abx80x_caps[]`).
Therefore, I'll drop this patch in v3 and leave things as they were
(i.e. autodetecton after the `if (part == RV1805)` ).
 
> > +		if (abx80x_caps[i].pn == 0) {
> > +			dev_err(&client->dev, "Unknown part: %04x\n",
> > +				partnumber);
> > +			return -EINVAL;
> > +		}
> > +		part = i;
> > +	}
> > +
> > +	if (partnumber != abx80x_caps[part].pn) {
> > +		dev_err(&client->dev, "partnumber mismatch %04x != %04x\n",
> > +			partnumber, abx80x_caps[part].pn);
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* Configure RV1805 specifics */
> >  	if (part == RV1805) {
> 
> [Severity: Medium]
> Will this check now evaluate to false due to the autodetection resolving to
> AB1805 above?
> 
> If part is overwritten with AB1805 during autodetection, the RV1805 specifics
> will continue to be silently skipped. This leaves the device vulnerable to
> accidentally entering test mode and leaking extra power, meaning the patch
> might not resolve the issue it describes.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725145718.14733-1-apokusinski01@gmail.com?part=2
