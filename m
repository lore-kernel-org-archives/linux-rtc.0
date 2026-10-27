Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098959;
	b=o17Tno36sy0lpSToR/MQlvRpHKyrGZjWW92Yz8eBI66jAhkCTv5pwIW5xj4JPfFqOEcp
	 t4SZRBvb5BfkURgFcW/pQylpCxmuaPUoUjnVsScTburpJqSZ6li7Q6jT3vtNiUhKm+ZET
	 SYzwZgzkkTjm225PH51VJprLM0GAgOZYjoHfJ9hzLM7YisWGjrY07rF7vob+2l3Rc/jvN
	 SKpaxjdbHl0cgkfLnpcULbzE8YDX08W0v5aPaFgs6hInHJutQl5b3QJ1apbzbzzPRBR4M
	 jvWsI5nSPA6KVCb1zDBPJ5gozbUG4pa1mdf7/1D2aTJ2p9uHr5S2XcPkQ38yLtv620g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098959;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=S8N/j869HNpgdeP7/QOiEpi1UDU+4/5IbfLyzxRncAg=;
	b=maJL23ATdGQW+ORMmOLBTjP0K6zSdRl9eM88N8V7RWzdc/Phptc3ju1Rju9ZmtjcB5wt
	 hFL1NuLoehmomEtmyvJfP5zVMYvlKk2ck9y2nyYPhCwuF+CCt3qzZNHaf4K6SrYIJ6QqK
	 QxZRjMRNkB4IYMxCbmKV6IkGZL2mjxl1AJP4HNdzfMFgtT42LNYCpWJcx8iUs764dEqgU
	 lUPygnYdAhwJnZByS+PX2MfFhFI7/MgrPPOuKte1/ANpF9c0NWS4bKTNowH4o3/3g4Et1
	 IAR3n1mihQifDrMK4eeiNz8vBM+YkQ+Jyjcxt/el7ocMIz9/WQWo8QVoxDZtSOXeqHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dncX0fas;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A1606A321
	for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dncX0fas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0719C1F031E2;
	Tue, 27 Oct 2026 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098958;
	bh=S8N/j869HNpgdeP7/QOiEpi1UDU+4/5IbfLyzxRncAg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dncX0fas7PcpQWT+nwEfarx1wQDoTniDjmYWRDC0U8dT9cnhGcOjgIRuIXKop3Qcl
	 Ik/BcRaPP/VB0wD8Xprq6jUfrjTU5lxOYCuUL5VYTwlANg240GnrO8zO2S48VnP0kv
	 QarObIXuWa4XxEyUJOlRvU6qpc5AJpHQuNwBidhuy46Y4w7je68xUNg53Sps218IRu
	 Yk5NISxLSMMc2sC6F+0sNwLUY7yv1zePGQ4Nvp1DHeEMNCgH4mZkwDxZSVW1bLiPw9
	 GFpdWMuGkVYvCr9pduzi7wUnlgB2OFJq8OSbLxtiOwl/uBGiVg6ZBxXr16h70U/enA
	 U89ksbc9vcN+A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 738821980047;
	Tue, 27 Oct 2026 07:02:36 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 27 Oct 2026 07:02:36 -0400
X-ME-Sender: <xms:yoTgakgu_mMIKfyQ47EieUj_B330f4LH8rRYN9U7UcrVmjDJx7as7w>
    <xme:yoTgan04veaTiDvKWadmHmvWcBApQz1ZvA9-7y7b-j1PL7iWvuGl_-SEtq_YFpDl4
    aALQamk2X0hxxdogei06l2_Uv_msyVSPRH62yp-pMVNVzknhfbpYdU>
X-ME-Proxy-Cause: dmFkZTFm99AU2XCv5XYW+MYlmeCZ9R1fW0lgfMXyRRSlHAPwKK7hKrQFekQzXnNPXdSnqf
    HSwSW77+GeBivgAdTB7qHdcQffgmQ47HmTpAGgur7vpbUkIzzxrIdyLebJyZE0Q/KNRG5K
    IJqwVnX+IkPAG2l0JkuGSb+i6wGfgQxPjIggcMtC/tHA04yh872g/XL713UULD9YS/6ZvY
    7prmSMosqHUriYB8GXYO9qtVHleuOMHD2BXi9mim9oah3iCDey1he/GQRGv8jM9Z4WSCsX
    W5Apn91qjwH8uEm2uNA1Lxuh1KCSoNGooRjKi9iNfseeszgsBG1Idf0zAEKguEoeGkiPDu
    26VFY9WoUjR9Q4K8yrRU2tSie+6+ay3SEHNl+6NXtKnjqk9faowKoaklFS4isww3cjs+bQ
    DcXl6atWEWAgjeEyGcpVjFFWlakxltQFW6OBnw+ZuuHZmBxgRZje193O22me/JsU1fbMti
    nXXrG1Yy+3xNRF3sO7ngfSS2w/ZY/AKmFVUIstv4g9OAOibZsSkxCpIfKvMSr75lIBgebr
    L5iORZ1EURmwYX5gn+p1/SInDjzsDM3yU2gjjZuCxvv/TLekLwzbGT5PJMovzlGV/9ixa4
    3r2wo9Eizp0I4iNZXrG9ARIsCRNCHWXOTSuOn21iodUvWLEUQ5ikHa4XotcA
X-ME-Proxy: <xmx:zITgalGwRXqGAZTmJYbeGWqvPkGo_5lj8QOkS05tr-ZS-4ACZUjfgQ>
    <xmx:zITgasncjnNenxeenaz5ArplLQiM67N20wYAVlbtNSD_w2B2tGd5fw>
    <xmx:zITgapZzwFC3w4QtCKiRZ_cXlqaXcHPCqZo-AxGJML2K1dmpG4hqFA>
    <xmx:zITgahFpwXp7mzpkUdLKwT26CU_5jBkKBko7OYQAxW9ha8b3Z3H3fQ>
    <xmx:zITgaqLWH-qZTyQjVvWKZW5vj5S90Fas1yEXpSJljebiT6Gyu2zjDcyX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C4F92F80090; Tue, 27 Oct 2026 07:02:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 12:02:13 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>,
 "Linux ACPI" <linux-acpi@vger.kernel.org>, linux-rtc@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Message-Id: <8214320a-d7fd-43b8-bc77-bc8425642c21@app.fastmail.com>
In-Reply-To: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH v3 1/2] ACPI: TAD: introduce acpi_has_rtc()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Hamza,

On Mon, 26 Oct 2026, at 16:21, Hamza Mahfooz wrote:
> The same RTC may also be accessible by other means, like the EFI
> GetTime() and SetTime() runtime services used by rtc-efi, which are best
> avoided if there is a native ACPI interface to the RTC.
>
> To allow other RTC drivers to stand down in that case, add an exported
> helper, acpi_has_rtc(), that returns true if there is a TAD the driver
> will register an RTC class device for.
>
> The helper looks for a platform device matching the driver's ID table
> whose _GCP indicates real time support, like acpi_tad_probe() checks,
> instead of checking whether the driver has bound to such a device, so
> that callers need not depend on the order in which drivers are probed.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v1: 
> https://lore.kernel.org/r/20261022211304.2285792-1-hamzamahfooz@linux.microsoft.com/
> v2:
> - Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
>   acpi-tad (which allows us to simplify it quite a bit) and declare it
>   in linux/acpi.h. (Ard)
> - Add acpi_disabled check. (Ard)

Next time, please use a cover latter when sending a series, so that you
can capture these changelogs in one place.

The series looks good to me:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

I'll let Rafael and Alexandre decide how to queue this, once they are
happy with the patches as well.

