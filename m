Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353A4C10D8
	for <linux-rtc@vger.kernel.org>; Fri,  9 Oct 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544962; cv=pass; b=f4TiJGHIGMJ9mMdO1uo7Xf8hejL63Z9u2ayI3RrwahaevfsBAEoq2cZ3wr/lRQLr5BbK3XwcY75tf6WH63TbZlF/z/yr3L16oUljcjePyAZQIHAQGdLx/tl0h+1mO57bt5Re8KV4BQmFpZIoklcBSnPYnu+seRCgIzIQ61lQJG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544962; c=relaxed/simple;
	bh=RA8fsEDD5Aia9QBWoZvERTD0+3MACqfVNv505KJYqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCv2LM03P88Grnsbtl7ngla+SzyuhpWlG09sEnrSlVeJBEg5urqeO9PqoLPIzAhK86zCoPYbY+ZsnZ2BvZbQhmx2iIehvibgcNpGshCUysh7dl+BlJB1tgCwQVDfv44cxaAHN69/iPWQCur3sObpO3YAFUG1DhmZUQKaIlJIE5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b=tMNM1F23; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b="tMNM1F23"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4649b35bso5969692f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 09 Oct 2026 04:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791544942; cv=none;
        d=google.com; s=arc-20260327;
        b=X5oalnHQ8wsGl0whpYolEM+Kl+KXdWLWU5pawv/ULwO9zybiT8VbdfjJlj01Im7W30
         FIdMyLvA3oOhPTrOU+qoIU85Yf31h8QDdaJbqha2VtWYyjJms9kQeI53EdZ/zBGIXQZs
         aae5O7S/P1Wk0CCnJPXQpdbmsq3SuHhuM/xCpNfaiGCvJCSQRgJJLwKq6vQMrdFQL7PN
         LMOYa0EbMLHuT1j3EFlZ4jCLjPy93JpzzD0L+f9+kvz3+70zyFHQvEbPKdg4mvcn7iSM
         nZAZaxhdWriZJrMVcJCwa3NHspX8v0s+N0QQqMZDBfxVmYL+DWdK8W5v7I4qFG77tcH1
         7lrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        fh=bzPaJf6gC9xEo8c8nfo6ewjhuDVmQgV80kBv5jy5nh8=;
        b=PokHef1jJPUh+CkL9/Aa2Jg0Aypzb0FMJVPF3s4ffJmKYyggPLTfohcKmWQEYHFP7A
         x7ekS1K1ijciJKFQ6hrAPeUcG/wOOKfyVb5PHhjWkksBO1FusxHvF6YJevzVOD86nSYC
         t5wFhznCC1RAVv2hjrTgKOTDjVJrsGFRXVOQPVwh5/vdEQwwwq3/cttJCsuUbJAyDNsF
         ZPhJmfm6X6NLzoMAUvIUQurqQiP5DKCnhg7AQOqrF1gurWiCRkfnPIfSE0Hf8RWa1TF5
         lM7HL97KQecyTLs/7r+hXyw6Xu1EbtJ1rZAlHSL5Ib8QLM926EJLemZ2kd93uDdpo/rT
         d8IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1791544942; x=1792149742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        b=tMNM1F23DqkYhX3cNSTqbrxqMBC/HeIMYGg5cie7+Lfcw53AHQrMZmEwIQ7wmVJITu
         8OafZkSuRq7T/v7rG/p2h1G7b3HAKNuT0yM0LcDFLsANUIPR0K4qtZprRYa+RD02E/WW
         xygsuzoa+6HB9Bk/v7L+c30ryXcIj6gV34+kIjuZo0wnX6lcNEG64eNDzZI98GdsJnHH
         q5AeDsYbxIcgb/36d0bZQ3jil/Q5uBHO4qf0Ux+Rgc3Q4vj6I2pDD1xS0S7SiRBviGq8
         BE57fLIraGJT4TLsqDoH4eOuN4vdkSUDbzxjQY9OWOxsv/5r4L1wdqtCa8ZQWP99cLuK
         C4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544942; x=1792149742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        b=NvodjEO26u+84czZYMY2Zpnbg4d+YibpswlCaqGy1CMYRLvzyG/q0U3GCuWqfcyKne
         c0vk6VKRQC2No6R4krxIDmR6eY+GVbxxlfr/360oTWUH2gXq2hXXCKXeD4aHhnP10cLz
         eXnY5U521J69p0GON8MItGwqHGEEP0kI7uZFaU6I3nfCJkw1oNxCv8/TscGro9pFQQRa
         cE0ZjHLstFXsLrrKI+YvY9S49mo5oxRTdSo7UBdlvkYlStjc1Av1hBuo64bczFGfY+LR
         7AvcJ3Zk+czVbce5jQUjnm8zxrI8WxkhohyH1bwpWLIc3DfpBNhBkZWx6hbGv7PaOcJM
         jxTQ==
X-Forwarded-Encrypted: i=1; AKwUvByvlrBvIRF2rFmKiPj6cmEv9FzEDwI0Y3TrrpaOn0T3NwHB/HEmfj2dSWB3/qAvrwk1GKA0K0z1Bq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpqBhf/HTJesggM/0/a+H3+k/Wg88/HV6djG8sARZJ6VVSBc03
	bXhtuS+nOQBh48pmRlmK0dvAQgcD9DRgoQZB6erKsOvXT5ouD/9n08Uu8vR3/IE8ScQy4JLK3Yp
	Vv1DV0f8YfuDfOB8bH4gVFlYOqKLw2uBdQhK6cjYnm40+wDX9HIt8/O5uvA==
X-Gm-Gg: AYBFou1Y4jiUMRB/F8S63Wtg4gKDY/r+I92l9Ep2xpo4cYtpBG/rL+ql8cUDsYLo3jJ
	lkDMsmjTu3qxm6mhgKDC79pyjrLLpcK1piLkppy24yWGlwxi+4cRkgoiGTkF6J1LtrMU2LSmna4
	Ry9aLgL4fv5DLfrOtxNihx/Ty2AYb9wQvvndBG7937tSE4brwl4vxvsx9Fs1OJTB2Ni1eU7BgNr
	LHbUSPqsdrrxq2cXFjRbYgD5p90HBZxMrnVHQvplYnV59/Ql3DXxLKtEmS9CwKUl78ggWwud8yP
	/u6I/sVdnQiSzhzFherL0uV31jCjET6KiS8AZA==
X-Received: by 2002:a05:6000:240b:b0:487:169f:d339 with SMTP id
 ffacd0b85a97d-48dbacef394mr2591008f8f.54.1791544942262; Fri, 09 Oct 2026
 04:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
In-Reply-To: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 9 Oct 2026 20:21:55 +0900
X-Gm-Features: AclHuK8WMU2f9s206E9gcJrWGqo1xWTIQN0qw7OLhbmsPMhw7KL5K4OmY2f9m7Q
Message-ID: <CABMQnVJzcpMqfa-J_rS9rQksoz3XCKrWYmwiD7JU0zXx6BKyPA@mail.gmail.com>
Subject: Re: [PATCH] rtc: pcf8563: pass the driver data to the alarm interrupt handler
To: iav@iav.lv
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch.

2026=E5=B9=B410=E6=9C=885=E6=97=A5(=E6=9C=88) 8:57 Igor Velkov via B4 Relay=
 <devnull+iav.iav.lv@kernel.org>:
>
> From: Igor Velkov <iav@iav.lv>
>
> pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
> registers the interrupt with the i2c client. The handler then takes the
> regmap pointer from the wrong structure: the first alarm oopses, the
> level-low INT is never acknowledged, and the interrupt gets disabled as
> spurious.
>
> Only an RTC that has an interrupt (client->irq > 0) reaches this path.
>
> Fixes: 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on ODROID-HC4, 7.3-rc5, with the INT line wired to GPIOX_5 in the
> device tree: the alarm interrupt fires once, the alarm flag is cleared,
> no oops.
> ---
>  drivers/rtc/rtc-pcf8563.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Nobuhiro Iwamtasu <iwamatsu@nigauri.org>

Best regards
  Nobuhiro
