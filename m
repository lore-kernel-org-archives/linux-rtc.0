Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBE4570E8
	for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698502; cv=pass; b=ZJUjO6wNq6N9OgfSWbxwuGHY6lerrfaQ35hUfvtD5i/DJ6zyDkdzFB3t9DgL5VdrOZ5MZdws0/ghR4e2RjVtT80Hb0fEtURSVBc9tbYWRqBwnbchMMwGEJsH2LZuK+Q3E/dzHcwJHmOZ4fWZNHCSJh9L8nNPuvjt9TjMOOVhfds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698502; c=relaxed/simple;
	bh=HYuWGT9uBk6DYJSNsZ7JcYY7syMooP0ymWSP1i7eR5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHyekF2s8cf6bNsaot5pBu1fl4DKfXNGF0c7KEgA1MDtt7bcWuKBw10mTi081MQNVpXROcqYsDt3abecLYG4FSA366YuCxhofu7NXdgDeDB1BSxl/Y/OLq89PXZMOTU43Xrjjg90Ik0DiM58b559370m3IHMx+H2wXkxlTtHUFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwA2gp9m; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwA2gp9m"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c70f05859so1213981d50.1
        for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 02:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786698500; cv=none;
        d=google.com; s=arc-20260327;
        b=Xx2NmxXP1zCeNDJSeLjyvYohbLiZL5N22MGWdCKsSdVjgBLk6mIci6Yr/aAKipHO+w
         3+KR7rnAcRdK9J91sG4ECNgi7yzRhNosWb7dMkK8s/sIu9PbmLqhdVkO3pH6efBD5Osv
         IU78DcU+gFWpLO3utmSAUsdD2rBBVQD65ZuJt1hiDnKWYu/HtjHWsp/cjCXll6y+JYf4
         9DYsGKxEaQ+KadEFbOzRCdsak4tVal6A+sKaEigLWiTHV33u90a0HG+OS6ODsyJu73JV
         axkI8YIK97GwL7ef+NrPTQoQwGi61vE/mdkhAGWdDjqwfYK/wAzFyQe8tZi0NANDYXxP
         fXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HYuWGT9uBk6DYJSNsZ7JcYY7syMooP0ymWSP1i7eR5w=;
        fh=b7oYshCD7iiSlwYcwgH9kc05bkfDYQXKV8Xkyk4IwyU=;
        b=VfPduOpnjuLp3xVlyri64XUKCm5Uri7dHDEnIdVxvz+dpErvQofd2UyTBfOEIEwdl8
         nOlyYtVcKiU9Jnxpu+ogsxCB/jv5dDmSmQdTGi2KjyqQnsg2vCA2Rf230+Xo623nDUrh
         9o8psXKQHXVNFtIEqtgCyb8jow2jvJEbtpIGogStXvdJRGM4Jnbrl+l4ocSvLzM3sBop
         dFZAeYL491K40iAhx/otFMrdxfqwmcKal5J0uaUgY2AUu/O+FNtcYfG26PBNzyWqI6aZ
         C8bv/dXkWMcyAx+YYmuMs++jIorC6Wk16lox4RxdAzzEgc5GO3IM3RHiPqZmfBwElpEO
         Oupg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786698500; x=1787303300; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYuWGT9uBk6DYJSNsZ7JcYY7syMooP0ymWSP1i7eR5w=;
        b=HwA2gp9mIBUqDAocA0WAZa7eXnQq5Dm9bOFyTOg78u/hsSWb8B8YdvO5+2mhzoGarx
         e+M2IxLQSTFenwfrmx3CeQ5E0WnJfjA/YcEoIMGMCw21qBxlPzTd6F2KxDBO8B2BKIAN
         /4osf6Yx2wnNuDUkN8FrB6BHorUpupZXqobE5kuvBC4I1F/CewJpO2cKEnGNyU87w8X9
         CyWHazcmy+ULaJuw+d5A+eH17uUs3j9NZ0LIvTRJJLb5r+w/B9w/5Zta7tzEOEwyiOWy
         OcuAd63cqIUo5UK0MHch4CQTItRHqiINNG7sG2/c8zv+PtQe/LKUf5Q/ttGRRF1P+Fm2
         Nm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698500; x=1787303300;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HYuWGT9uBk6DYJSNsZ7JcYY7syMooP0ymWSP1i7eR5w=;
        b=mlntq9EnSnfETCUA5hfrH1EhBwJzkzITmSc65ULT7pBjrIKLa64QyxdOEe0sjPsrHa
         cMixogT300y92KDWq+i7Mjo96f8cV+s0VxTNPuuyYoPprn5QbtrE++D1Fczh9d+a6VaX
         AaDt838NQohACpcK/z7RRyjI8IWHQxWZ9r2lTRPAl9H+qjCOiXvPdBJB0s/yF5MEZ6nH
         CJuthlbFAMNF1iJHHPmwQCizOH9pN2DpzqfBBLpLhnRAiZMhs6sLjgg3RIx3+4VzbWGj
         FXcePPUNtQvLj1j32VqUYNp6/y5F3ycXlZgMBAizwhihIzwrLkd3cJYRIfPhGKl3E0p9
         mDEQ==
X-Gm-Message-State: AOJu0YxNfgmNAITVMa2/Re75eFRT7SY/0UCdNHo/FOxu1nYWyDRuezDo
	vKLtE3LgdlZLJbav2Mvfb8qaDh/Aztl3vRWO8reTgsaoEwVCpnvZLnC23JKkZtjr7JGIvKBz4qC
	6XtZgt/jN4nJP3h96HRxsFuNwARAM5Oo=
X-Gm-Gg: AR+sD12iEBaDc2ZnySyXPUqNLUaNeq7KGpuPgyLfYVXnVg0la4IPZmg7xLny8SYflrY
	MpFO6xmAvBZreu4w94Hftmg0Bj6RNid14Gtt864ryOVuyJzNftGyQEAief9dkPMybd3725fECv2
	G3EzHe4jlkcaPKYdqfJp7yo1f38YZq5ee/wW9LhA7b+UHuY/+vId8XBV4tca3+ml4ZDUQKYlw2N
	uCRwH1oeZlON/zLDt7dznbOkZhxwo32Jr7MiaxOllPGrMKs7zl+YSfzjFe8yBKH5jkHCMwRjfwM
	8gmWoX2g+0b7Fp+UBZABDuRfxij7Yae51XYH5a6kVnOpbXcSm3n2BQJV/HCaa+dbJvSNNeQQuJU
	EoDyNQw==
X-Received: by 2002:a05:690e:47:b0:668:99c8:bf15 with SMTP id
 956f58d0204a3-66c72b054d2mr1376716d50.11.1786698500469; Fri, 14 Aug 2026
 02:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624055648.127399-1-challauday369@gmail.com>
 <178406687202.3036881.4468660016404184803.robh@kernel.org>
 <CAAj-GBnn8rGD6o5HmVfYtEksXsL8ZPKcc_AbfKUEHtTsN1pN-A@mail.gmail.com> <20260813191817.GA1981719-robh@kernel.org>
In-Reply-To: <20260813191817.GA1981719-robh@kernel.org>
From: Uday Kiran <challauday369@gmail.com>
Date: Fri, 14 Aug 2026 14:38:07 +0530
X-Gm-Features: AUfX_mysdJZURZMpWD2u5czIFjSBNKyPyqpb58_YjGlV5lTuJ2_g3vYfefsKrMY
Message-ID: <CAAj-GBm7GcbyB-A7R9aomVCxhbh7d8D7tUxO3qCMYZV8d2N=Xw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: microchip,pic32mzda-wdt:
 Convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	skhan@linuxfoundation.org, tsbogend@alpha.franken.de, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"

> > >
> > > Applied, thanks!
> > >
> >
> > Thank you, Rob. There are similar microchip, pic32mzda patches related to spi,
> > sqi & rtc which are reviewed/acknowledged.
>
> I picked up watchdog only because watchdog DT patches have a tendency to
> get missed.

Understood Rob. Thank you very much for picking up the patches.

>
> > 1. microchip,pic32mzda-spi.yaml
> > https://lore.kernel.org/all/20260622-ingenious-finch-of-fantasy-7bafaf@quoll/
> >
> > 2. microchip,pic32mzda-sqi.yaml
> > https://lore.kernel.org/all/20260625-omen-stark-6bb827ebcc43@spud/
>
> You missed sending to linux-spi and/or Mark B on these. You'll need to
> send another version.

Sorry, I missed to include SPI subsystem maintainers. I will include and send
updated patches.

>
> >
> > 3. microchip,pic32mzda-rtc.yaml
> > https://lore.kernel.org/all/20260703-identify-cringe-ef88079923cd@spud/
>
> You missed Alexandre.

Alexandre Belloni <alexandre.belloni@bootlin.com> is in the send list. Not
sure why it is not picked up.

Regards,
Udaya Kiran Challa
