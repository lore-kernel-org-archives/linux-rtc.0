Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600273909A8;
	Sun, 27 Sep 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522333; cv=none; b=nE/5O/2jq/84TEUOx+GljdjRWWwDzeHuN1mTEDulxrIsPPqkSJWJTKL91hqQAmxNw1P84OsR5/6QbbtzDEl1//7TBraz8n35kG9wEhli7Wy9pi5znHFYZQM3BFGA1/h9flJGoZTJOgtqsP1+ahJ0pqCMteZiWH9jD2DbiUZN0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522333; c=relaxed/simple;
	bh=sz3mE0aNvTBitGYqiKsVcL/guwvkJYn9bygbCfEOIXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dba500BdgjL9uVRpPqNHKvqcSikBraAfca8Mq5xqS3lfSKrqyKyXZoFbMZKUJPLiCe69mK77NXnXIySBG0Ic5lFBeaPvMUYNXE+cO6tugLuJ/ET8siwffFbYxhKhTB5JRbZREryMmXnqljQOeh3jUfoa2HsuKJIEAsPQPBv5ZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOM+KVnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOM+KVnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A351F000FF;
	Sun, 27 Sep 2026 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790522332;
	bh=sz3mE0aNvTBitGYqiKsVcL/guwvkJYn9bygbCfEOIXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOM+KVnSQhJRNwVYrYJE01eQrX+He0JVYBjJo48WEnhIKE6z87JJQCEVeTpX3JR/y
	 h7CZ+K/HFFGtFm+hoyl2q2CdrOsj3unhpjgPoVmuJ60IcGxl/8oI/fCL8bSlniIkda
	 JnKGEMeooUkurHej2fvZ9t9ZlvfktmXqLqEP0zVPTJmUzC/7W/42IxIHt+DXvOkZS5
	 Iuhw59wZ6Zy03m+9BepQma02Y359zAHg5z19MwZlkcBDCJth9BaOvRpSk6dC4CNYVu
	 Iqb+nkgcBcIEKjPHBVhMpPU4qHt59b768ezegzms1JADzzQJB4nNaHFfaoDNrV00AP
	 tFtQIY4+0eLQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] rtc: sun6i: add Allwinner B288 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20260927151016.186493-7-pmazzini@gmail.com>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-7-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:18:51 +0000
Message-Id: <20260927151851.B8A351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The driver only uses one alarm interrupt, so no functional change.
>=20
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927151016.1864=
93-1-pmazzini@gmail.com?part=3D6

