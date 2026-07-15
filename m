Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210640096B;
	Wed, 15 Jul 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138807; cv=none; b=Ri0y69Qpc3DQtQcdl3Su1qPWY9UVf7A0FG118OAOuzSBlAo8k6SfXutA2a+LIrhNfRNw9f1bX0/PzCpoADZHHkqNFQJe8Ui0IM7NF9TH3qnot2pgnhKDXgDZggQ0M04IWxrVGweslwgIUHhHd+tyDCmkQMu+T+UlHQkFskja18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138807; c=relaxed/simple;
	bh=oTvCovZvCb+NUZipFkeggojWBi0KEwNl5Y4y7LfwLBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bKuraDUd9wO5nwJ3rWpbME97BwGmOwufU/gDU46Vc3Q0sBPZC3GfRkattfiNGQNrs+Cjf6EC1QgsKzztmb3v72qS+csb9Vz+q+9k1ckmxqubzhWDEkx7nValwkkRN5Dcxz4C5YfBbmpqnUSiXxSs2r9RKBz/+QBcgIiA/8+G40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/iTq+b2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/iTq+b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0011F00A3A;
	Wed, 15 Jul 2026 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138798;
	bh=RyLal9196BZ0JxNLdnbSmDvpEiX9jdOjAkyfP2izTK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/iTq+b2qwbKPOA29pPHoCFaN5Vb4droj6txZ/QuW86q3sjXP18k8FRB6raCwtZva
	 dyZ3coK8rWjNlRbJBnBalJLROqJVFMkf0ZPLhCohC4+Yn84KXeobHBQmt1hVEG/lsp
	 D9SgOupyKKCdxmWXP4SGUMQitBXWNCYReNMNM6Knepen10/S6aqs3iPq0gofYEStGZ
	 lScUrnGtvHDYWid10kipgBwCZ4a3qMe8wjAjhSrqOkMcl+PXb3eDgOSubC30cRBC+q
	 f0SrMO+T8UMURISnuM50PAH0UdK8dJtk4e8cDCz1Ly51qHtHFEOK+woXVq2wMYO3Ys
	 VYdN+xQZuwUaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] firmware: meson_sm: make reg_write callback take
 const void *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: lee@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, mfd@lists.linux.dev, imx@lists.linux.dev, ojeda@kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
In-Reply-To: <20260715175229.24672-7-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-7-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:06:37 +0000
Message-Id: <20260715180638.0E0011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent calls to `meson_sm_call_write` or `meson_sm_call_read` =
will corrupt the shared IOMEM buffer.
--

--- Patch [6]: [PATCH 6/8] firmware: meson_sm: make reg_write callback take=
 const void * ---
commit 05903fc223bec5b04f497c8b4bf66c4c6d90ebfe
Author: Link Mauve <linkmauve@linkmauve.fr>

firmware: meson_sm: make reg_write callback take const void *

This commit updates the meson_sm_call_write callback and its header
declaration to take a const void * buffer. This aligns with a previous
change to the nvmem_config API that switched from a mutable to an
immutable data pointer.

> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/m=
eson_sm.c
> index ab9751a59b552..5d4da2e3c3a94 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -196,7 +196,7 @@ EXPORT_SYMBOL(meson_sm_call_read);
>   *
>   * Return:	size of sent data on success, a negative value on error
>   */
> -int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
> +int meson_sm_call_write(struct meson_sm_firmware *fw, const void *buffer,
>  			unsigned int size, unsigned int cmd_index, u32 arg0,
>  			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
>  {

[ ... ]

>  	memcpy(fw->sm_shmem_in_base, buffer, size);
> =20
>  	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4=
) < 0)
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does this function need
locking to protect the shared IOMEM buffer?

It appears that concurrent calls to meson_sm_call_write() or
meson_sm_call_read() could corrupt the shared sm_shmem_in_base and
sm_shmem_out_base buffers. If multiple threads concurrently write or read
the nvmem sysfs files, they might overwrite each other's payloads before
the SMC executes, sending corrupted data to the Secure Monitor.

A similar pattern exists in meson_sm_call_read():

	if (buffer)
		memcpy(buffer, fw->sm_shmem_out_base, size);

Are there external locks that guarantee serialized access to these function=
s,
or should we be synchronizing these shared memory operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D6
