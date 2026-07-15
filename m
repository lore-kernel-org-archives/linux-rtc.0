Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B23CB574;
	Wed, 15 Jul 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138469; cv=none; b=oeBlBIvVVOwzbM+WRyQW6pqC+zV1uAnDMcd4JVyMmiQDMk0rtMD2tpO4dNOBKPt2jHJMD+iE0TXSkjz0dtwAGjkKJBWwTMo4gFmdz+PqK9VkC26UPC6MdJQo4UfKzzPPC1G6Elx52fac9PPDgmY+q4SqsR9z50ZeqnlLmkavJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138469; c=relaxed/simple;
	bh=BDhjwYxP0FYqaf8PshiPlq65ufH70jUPxodm53E26oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGVpgVYh+u12FL3DmqCj9MpFfpjtK9sXsqjtLUP7dqhOVWHaEdGrJ/7+0q10/8fyxDCfD36WHFqy6pIJhD5PLVQy12jboKCTdjQgmN4MrSwfZXabMEvzQOC9jsQrqXmenSZ36qSpCNIZpxAXCp6yyr9Sw24a6+vn+mxY/tPho5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx0YuZW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx0YuZW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE0C1F00A3E;
	Wed, 15 Jul 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138457;
	bh=d0dsrItk9jXayM9Q2oV+GZ8nC06mXCTAXStu/9l8J9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cx0YuZW9Mlvd6W/dp6K+vSWTyT78ZoyO33t1J68uMTGORjw9nmW1QhWjKoYT5IHdz
	 CBMAHZQmuWeUuR1+QIYWKK+ekXkaciKqkKDgbhVvOY30QJ7FFDU3RYDMeJkWc3d0Lp
	 czn/wWie/U61BRuwHFVWZwI0/T0m7psPSP5YNWAMgLiuRfj5RuHpztvG6hXjHWFCGj
	 RGCkMyYgjJn570ulTmvGfmUQM/6bSM06xdJbfWDRYSqkb5Ce21LaOOYWXJ8uSSydRC
	 LYGCQaQCj3x5frvNF1/qz5afWx6VS1VQZ8qxu7Q1DIrPx+qHqtijty+kUthDB6vHsG
	 MAYEUJ4uCMM/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] nvmem: core: make reg_write() take a const void *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: linux-sunxi@lists.linux.dev, lee@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-amlogic@lists.infradead.org, mfd@lists.linux.dev, ojeda@kernel.org
In-Reply-To: <20260715175229.24672-2-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-2-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:00:56 +0000
Message-Id: <20260715180057.0EE0C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying the `nvmem_reg_write_t` callback signature to use `const=
 void *val` without updating the implementing drivers causes widespread bui=
ld failures and runtime kCFI panics.
--

--- Patch [1]: [PATCH 1/8] nvmem: core: make reg_write() take a const void =
* ---
commit 465aa1ef7ad6475c286716a1fffc7cdb9b6f09dc
Author: Link Mauve <linkmauve@linkmauve.fr>

nvmem: core: make reg_write() take a const void *

This commit changes the nvmem_reg_write_t callback signature to expect
a const void * instead of a mutable void *.

> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provide=
r.h
> index f3b13da78aac9..e62285836cbbe 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -19,7 +19,7 @@ struct nvmem_device;
>  typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>  				void *val, size_t bytes);
>  typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> -				 void *val, size_t bytes);
> +				 const void *val, size_t bytes);

[Severity: High]
Does modifying this callback signature without updating the implementing
drivers cause widespread build failures and runtime kCFI panics?

For example, drivers/nvmem/bcm-ocotp.c:bcm_otpc_write() still expects
a mutable void *:

static int bcm_otpc_write(void *context, unsigned int offset, void *val,
                          size_t bytes)

When this is assigned to reg_write in bcm_otpc_nvmem_config, it causes an
incompatible pointer type mismatch. This leads to build errors with modern
compilers or -Werror, and will trigger kernel panics upon any nvmem write
operation on kernels with Control-Flow Integrity (kCFI) enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D1
