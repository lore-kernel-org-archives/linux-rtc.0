Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794474028;
	b=k3J0907+NycSXjpqsyfEWrr2As6jRgK4Um///rZN9hlu/G8dcnIq/4EKnoHosI4JqItC
	 zDFzQq1XwdLB3tR69HgEtKOknTABvlE+3AJc4Vsd2KIbzouV5WXGI/lLwg6yRMy+TYoOI
	 dglFJejC4HXlrrV9rcK39O5GIhEC7ON1ek5NBwT5IqLMlUpyISuOKxDH0CGwSgUJJZFk9
	 aB3dv3Br/z+FYoDLExrkbt/RW1nGBsXTJJccaqMDQV9WHA3mdKPPCjblLdIOr1VvsT3Sk
	 vzXcrOYmCL/MFCjyosD5InKVDk7OejIaSlhZKCI6Y4Hrnw894jLu3+3afV3F2nRxiJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
	b=uVhxG+sOuvOfhBzEpFLIgRD1ta26/LqByR10webJ/9huCNpL1Wl1Jt226z2qRkpW6SGY
	 b6ttn/kIkTxBPC5vN6P+NJmglqhhzFTRiUiqs+x3Cayme0eeGAcXzaYFgJfVnHg5HB05S
	 scU2yV8LRBecnhIBO0+Q9WZUaGacNyUMongVOUrNAG/DzWw+EviS/ng+8UrH5CYP5jvXQ
	 Xso7Db5wZt4PtIYJe2WIwXDWWae11Y+pjK4nVDdSduu03wIwIYAjNi9IOIuEME5Ecz9m0
	 vISfybltOS81/r6LCbCSYJp0j1WMuaCPv+Qt3IrFjGcgbg3hUCrEmpaEimSySD5ywnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkxPwo4U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FFD606A32A
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 09:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FFD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkxPwo4U
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3adf89523d8so2105701fa.3
        for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 01:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474026; cv=none;
        d=google.com; s=arc-20260327;
        b=igBWZMlB8rFfgy4Ley6NZAiSSi/fCdkSzgLG4v2Rp8mLhjTHaPCRFQkRjsd41NbOTc
         KbQJZWRyNW2osKAKs2iPF+0gIJQ0P8s+oO5XTYqh9Vu3MRQZ74JigRpPaxgEX/jXppkS
         WWilQ7eVxAwMgUr8Qs/PZOSiG7O+jDcXHRATUdsKT7rV1YoVQdop8JEOKULIxpnXbvVc
         7n08PlLyyoodbEr4xxTEaKF6TluEtfHETj2aRyDH1wJwQPKGlni2U/z/FpVUJkyAmBrH
         IrlSYJ2a+cn74DFWILyIpO/M0ysfZWiJUtjq0HKX3+SU5pQDZmMXl5E+5W/Bm6infRxq
         cQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        fh=s0kr8TrSfcc7wwxvrCgZPLVDxTxPU5+Zei8rTbK/0tE=;
        b=ikW0Ss3I9wMwKI+BbitjAZPAmRhz/gexFTXmVe+XlJBprLsOArZxySX6kh52mUs0FV
         ZGQW65vDM2y9X3SfJnfkdWyuqQAKV56yaJJBcHFqb5tK2r+ndsu70nYe62mpm1S8WfxH
         96XIq+94SZk2FcCSQ/mJo/gCfclsWbXBj9J1zhlEpp8NLjTLtIPDMetx0plnCTJ6rPlG
         NxeXMRNaG6n175tLJz5xZTguLF6f0KRM6aRMwmHGvUwjLawGRtpzTg5sXchLVoAdbdgk
         yIECoJgr2gXtMVGY13mivc1aHsTbHPx7Er3gnqtxe/csRpMCXxjTqBrq/9UGABU0yxAM
         Iw5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474026; x=1795078826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        b=AkxPwo4UuvS8Fx3lKXS3acYjGFs3MoZbrWOg9QuGvCP9brgnlVOKm22vtGKmYXzlk/
         ZNkafoCJyRM0UfvHLil42Lvr2GEjep4oX8zR3S22ID5KKsL2bre1R3k1mxmvPj0Dm1Kf
         un/tDjSprT/xwYUWIoh2ThkQ7lQNzu4cgzcNoDs8xJ8UkmUFPmlM8scxu7yjNQ6m6Zsx
         gpoNv75Rla/J8/Ik9NVI3JsAGiROHf93tJp20uA79HJJ7xak01ga7+DWTUhkK+z8212y
         qazeHq81hwYnOk8UGeKY5C63lHfdxAvC/YpiAYDsAuHWPx8sqkBS70/b+KXaqTSSWahN
         JLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474026; x=1795078826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        b=bADEKCi+EA6Zn+ErKkxCoCUS7gcUiyUlrM3CzeRdex6jrJDx2DVNfyrTUMAs4h2TEo
         LSIWuc8oIyPHLhPdzJmTonAsl7FqPJoGor369I0R8GzlW+ov9NfWEy2hIUW8omeUMz2E
         bOeRlO5v4dhKBjmnGsGGEuSIjO4gK91Ao3/n/FgcNWcjlIA/lOfx1/NtOIi4hjYgEeSn
         J3uEl4tZZjkKhQ/ASASoqeAWgpg1+zE70fO54ZybwyduwHtxFGFTlvOcJYuSY4hnW3Wz
         T6+XhqguoaaMMX+Y4RWOD0FM4wPvqlW0VzMwFoKoYpGE1GsafKCNjqph5JdyvV3+501s
         9xfQ==
X-Gm-Message-State: APuU4Z9zLW/h15Ih4N+Yzb2BTA/tcc6IOZOBL5V0/kZzpgnj8KL25qOj
	M3iwoozKI9S9oO3ag30L1WetyxFLLT8BoUzy2Lwx7kqGXer9xo106MgvQbWI3vriT0ZiNRENGo6
	vD4QCjkpo5oIVrilrPxnr2VQ9D8/4WcE=
X-Gm-Gg: AYBFou0BVmBNgsIhBafH0CKkk343rWixlaf6KYid6O++U6oUFj1ybYLkKWz3hyqWBL5
	BQOesTy3rK4DVsIm66XdtZ4L9Gs1BK1TkvQE7MrRFlzq4Q/adYXK8qZibaHigtoayWVAI7gBLXD
	9qhW+9jUsAiROvj7oXl0GeJSepY0cFOX/Dluz2rnGPirt3KUdUIsvA3dMxJg9ce0XnixOGX2l+n
	Ggbnw5lcnK30E4meoz4EXDoZeZ5URKR3Xh5zMzFpgkALJpWHQB1eF5Z/OtINveVB/qKuGBUIajd
	dcl4j/iN15GEtfNkidkcsSSi94KbnAQ8Ty1KZBm1wOt0nL0D5ONeOAgOJ8Hqqi8GPLWaVzJzUUF
	1/9Q/D+tZ66j2Y2ow5P0k+re3x0EKraok8U8NOrk5vt5Blo9m9veLJuLrnbHFmMJNvfk6S+9PpL
	RVU3DxQd2QlLaP77iY
X-Received: by 2002:a05:6512:3e01:b0:5c0:b5c:4084 with SMTP id
 2adb3069b0e04-5c15d54dd2bmr1732485e87.1.1794474025804; Thu, 12 Nov 2026
 01:00:25 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com> <20261110074853cc5a8882@mail.local>
In-Reply-To: <20261110074853cc5a8882@mail.local>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 01:00:14 -0800
X-Gm-Features: AclHuK9eG45v9F6I7GV15HBzJqSwgKITGyUk_trjz8yzMuRHSrXtJn6NP2-qWxI
Message-ID: <CAEy9hNWaUB2rFwXFP=pmLv_Gj4Umz2CsDpN7ESJimOsVq2RzLg@mail.gmail.com>
Subject: Re: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds
 down into the past
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

> This is the expected behaviour, userspace has to handle the error
> properly: the alarm can't be set, set it for a later time or stop there
> and don't suspend.

OK. One detail: userspace gets no error in this case.
rtc_timer_enqueue() turns the -ETIME from __rtc_set_alarm() into an
immediate expiry and returns 0, so RTC_WKALM_SET and the wakealarm
sysfs file succeed. What userspace gets is an RTC_AF event right away
and a disabled alarm from RTC_WKALM_RD.

I checked that on the HYM8563 without my patch: RTC_WKALM_SET for 15 s
ahead in the current minute returned 0 in 5 of 5 tries. rtcwake only
checks that return value, so "rtcwake -m freeze -s 15" suspended with
no alarm armed and did not wake up.

> Never round up, you are going to miss deadlines.

Understood, please drop the patch. I'll fix rtcwake instead: read the
alarm back after setting it and not suspend when it has already
expired.

Would you also want rtc_set_alarm() to return -ETIME when the rounding
moves an alarm that is still in the future into the past? If the
immediate RTC_AF is the intended signal, I'll leave the kernel as it
is.

Thanks,
Arun

On Mon, Nov 9, 2026 at 11:48=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 10/11/2026 07:13:47+0000, Arun Iyengar via B4 Relay wrote:
> > From: Arun Iyengar <aiyengar1990@gmail.com>
> >
> > For an RTC with RTC_FEATURE_ALARM_RES_MINUTE, rtc_set_alarm() rounds th=
e
> > alarm down to the start of its minute, so that it never fires late. Whe=
n
> > the alarm is less than a minute away and in the same minute as the
> > current time, the rounded time is already in the past.
> > rtc_timer_enqueue() then gets -ETIME from __rtc_set_alarm() and expires
> > the timer from the irq work right away, and the hardware alarm is never
> > armed.
>
> This is the expected behaviour, userspace has to handle the error
> properly: the alarm can't be set, set it for a later time or stop there
> and don't suspend.
>
> >
> > That loses every short wake alarm. With a HYM8563, which has minute
> > resolution, "rtcwake -m freeze -s 15" sets an alarm that expires in
> > software before the system suspends, so nothing wakes it: with the
> > alarm set at 17:55:00 for 17:55:17, /proc/driver/rtc reads back
> > "alrm_time: 17:55:00, alarm_IRQ: no", and the system stays in
> > suspend-to-idle until something else wakes it.
> >
> > Round the alarm up to the next minute when rounding down would put an
> > alarm that is still in the future into the past. It then fires at most
> > 59 seconds late instead of never. Alarms that are already in the past,
> > or that round down to a time still in the future, are handled as before=
.
>
> Never round up, you are going to miss deadlines.
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
