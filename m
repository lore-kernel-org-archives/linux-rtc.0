Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595657;
	b=LFCMlQeoLumR2Wt76m7rYlfdSk3j3OCWbScOlureLi3rKz+PfiGJWDY+bmx4btq5cvfI
	 M8O+HTJEHMKrY/fEpkIV6AyQ0oKpnNFRNa5dncErvpRpnvnQqkcbPweUr1W3goaYgaiTf
	 blO4i528Xp2R0uXBK5fx0HcxW4Uw1aPxi/mqkTxfmnidTqlWCbU0uSVpiTcpMHmGiVxLN
	 0B7aJV22vOZHUzO7NECOEUAV2Ds77cmy/1/S2ttYfE6FGH5BsMf3mrFDeYEA2s20S0CVa
	 Cjs4q85cEEb0+3xLTxxDtXg9pD7J93GIl3L2KqI7HsG8Kvi46CE63pvGwCx5+NCG09w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/TouLeE5CSqTtKRDrK0lnrLg+ooT7NPum5np2ZZg48Y=;
	b=FbZT8USCWuZmCNkHGOqrwnAduzuua9r771TNq/xMZSomR3QslH/st7oPH5714WmArtAS
	 DQjKIwPdQTpriXPY5idfFEXbciTND0HYXNKrYcLdHAI+Vz7445SIDI/gbCWJinICrghlA
	 oplve/WYlTSctqv7PX0C1YmzFvkVwEoS6q5Spzrr4YW1/0ALJMLbIvVDjY65l8D3Ih0WH
	 Yds1pgiXkD3bajQtbS0ICojJyuUFLWS43JHEUJYHcQH0vxNzEUMHKMsChEPHrzYgyeEiT
	 ZdE9q2ZLo35FFxaXmZZNK/Mi1NT+sLXzHWZ9zWHiB6wpyi5O94OeGCAna8jMj0hEdIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEdyX+eP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A93606A64B
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 18:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A93606A64B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEdyX+eP
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c10dc41270so1813255e87.2
        for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 10:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794595656; cv=none;
        d=google.com; s=arc-20260327;
        b=FYqHrcChNlezTn/rgdebrm9F3eYGPqWdeK4HNksp75zflO39r722kisGKz9b/CEhx3
         AGGRjUptk+qP7UXFcGGiYoXuxI9nKD3P9u1MPRX+cvf7gNGQd3EjRhZ1ArfL/Myc3Yjm
         YcfmAjPKgWywAC4tLJA/L9tGyZ5A5/Vs9bw8FN1ykbwkL0TeuNXMf3IEDEh2j5wtdn3R
         e6Vu7e6KwhG/ca68T/sGlmkAErFirO84oIqCwDgxUFwBZyBQrvsY4h3UxksmT/A82baT
         fPwqXrNV7bjVKMRijGGSwbXnI2WfUmNZohSzeZRfn7QZ4rxN1VCe2LyDBvcRwRvPVnLE
         5n8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/TouLeE5CSqTtKRDrK0lnrLg+ooT7NPum5np2ZZg48Y=;
        fh=3e8rSBNX4TbGKXDsxu+cxGO0XPcqbnbvKLhlhA2WB64=;
        b=ZAe9aKLu+zsJGgVUwawnS9Awagx2pJYsOrRkSw5A8hG0BpnFsvmWrZOzsFWlyZboFE
         zdEpEX7Z5HjmjeyWjNnYTr6r+oJCoxMRSwVqbB/axm7WM/+tZwuAnk3wJ663o1Z9SQKY
         7OccyGMfkbyrRo4ij2B/+nFFIuRWe8jU+NOcE3BAdxC5Yt3TPQkEDmv65VSKbPB+YsM0
         eBMV4tlBasz25gzkZh2Z4CdKDNexskxSzLywlp1mMKOyw02SImbOjuV5skHyemUTFTAI
         B59rreD5OQvQ0WvTlD4oQJHui4UDfILdGykTA77FnrfwCZ/OKYnk6fqvKBNB16DeLLLG
         TB8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794595656; x=1795200456; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/TouLeE5CSqTtKRDrK0lnrLg+ooT7NPum5np2ZZg48Y=;
        b=dEdyX+eP7TiPMKe02c3Caa43Fv6Nre9Mn3HwID4QBLnMs6zpzSeHslV9PRcXzSA6bU
         KaVjpPS1KuZOu0IbTeMAfCUupz3yuuPrHdbTBIOD1zd0U2xRZ3HBOt+ow+4YWhZM8pqX
         +zBmeOzGIM/nX1v9kKMcLZIrCcPs0gAhAb79BhRzSm7j+81HCRLfPMScjCEzP5pmdU5y
         wheRiiT17Umfyt0dZp0GtUnxnw43oXt0CaqKADwmUzs5+uEHUPLFVgLq9pzo13bbq8Xj
         zWoJcxEmsu2sDDXG4GrNEZuBkVC1hMRhkIGwNbJy55pOYFp5yOfpVxd6dCwwCgXN6ikK
         G8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794595656; x=1795200456;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/TouLeE5CSqTtKRDrK0lnrLg+ooT7NPum5np2ZZg48Y=;
        b=IJe3etF+hrmXHOdd5NdvP7ixRK9FlCGWExhP7cPDA4fEdnv2XnaMI8f5y3kzlCVEiC
         rgcZWPF0OaW9npRM2sjuQ9jOiii5kPUY0eX3Zb9Kd/i2tO2LzKnfURnfWoXdosXzAWc4
         pDq2kWNXh1P8SSoYowgdSpaaVWfSB5VBrI1v5UZeV73bo4rA8QCHYUx14aEp2RYYrirn
         HgXCm/z6+PyauxmtP7QI1mYzBmSYOTKyRIHkzQPiSaA6rmE68WXMcdZm6T3/jcvyIPiV
         nxVOd+sK3o1PWXRDuY531mfny8wmQeiCgVPy3C0Gg/g1CU/crbSveVcXOPpKsCfhyIcp
         gOMQ==
X-Forwarded-Encrypted: i=1; AL+hErFo4yyXGw8EYsepsp2YH064IU1j0prHFhrAVFlOQ/G8sJqLzkHCKahK9J/pSXAMCiMLymerzU7/zFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z87GXTjcaR6lnPI2tR+Xm3uloi79rCi4sKQ1sKB3QLKCiifu6G9
	f04i8VsYbou3oehuQbaBVidVebYOvb4le8fIB2cgRkNqb6+0XCOt3vB2FcySHfV77qdiuAuJoy3
	xRCQlcePMPKWGs3gIlTmKu2R6GGSpMns=
X-Gm-Gg: AYBFou3mS+I5rhPjvtSBFurPIc9QOgcUAZXON3yOFtzyzEt8hPzEv56MGNLBK0m4xPg
	TF6I6lPFhCuYGmaBoe5Zok6ootx0NUgEUkEf2KEJkaI1z5cK0eKxTma3J13a0xyudPTDqpm6KXn
	F7FTXSrhQvFBRX+EWUxCq3LU1Sjfs/g6NIccAB3BEQiajr5zextjVgMgA5NogH4xtK7waLqHm/C
	nmGpRlpNozHjEuhma0z8RVsizdxa6Li1Altkv23bQjz8wzY7Swkrxv2u1fP7KNQTJ/pN0ikD0SF
	r31/HmOKEgPxJWa7iXmHVy49jWJKNoTz0Q11Pj/JR1jwPm0prnekTBeXSQJMmWQNStWtDmwKpjL
	2W1p0BOFzR3kwKot129O+et0GIggm63/1jKi6FXpBmzlhjxf+9v0xNdwMJGhpUZ9KC9kDcUdfoE
	L/30TpxxF7ADkpK83K4h/PtEGZOyeQ128ntcHxYacxfYkrR3upK9+jhvh6sScDUzuVwc5SgWcHK
	HSHiQ==
X-Received: by 2002:a05:6512:1288:b0:5c1:57e7:e7b8 with SMTP id
 2adb3069b0e04-5c1709d6aeamr1363556e87.17.1794595655370; Fri, 13 Nov 2026
 10:47:35 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?0JjQstCw0LnQu9C+INCi0YDRg9GF0YfQtdCy?= <ivo.htr@gmail.com>
Date: Fri, 13 Nov 2026 20:47:24 +0200
X-Gm-Features: AclHuK9q2FQYOnq8dOMrnJk4llHA8SOzZZPwRPsJjoi4SM9PvFMk_9YjuDE_nv4
Message-ID: <CAKUb7EBUeY=2zHTu5g1ZOoo0JAFiE_MAvTDNQta+LitQnVELoA@mail.gmail.com>
Subject: Re: [PATCH] rtc: class: Do not inject sleep time without a suspend snapshot
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: sabri.alperen03@gmail.com, linux-rtc@vger.kernel.org, jstultz@google.com, 
	tglx@kernel.org, sboyd@kernel.org, mlichvar@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I hit the same jump independently on different hardware, so here is
another data point for this patch.

Samsung Galaxy Book4 (NP750XGK, Core i3-1315U, BIOS P09CFP.023),
Fedora 44, kernel 7.3.3-200.fc44.x86_64, s2idle only, RTC in local
time at UTC+2. The CPU has constant_tsc and nonstop_tsc but not
nonstop_tsc_s3, so the CMOS clock is the only source of sleep time.

After a 27 minute s2idle sleep the clock came back exactly two hours
ahead. chronyd did not step it back, because its makestep limit only
covers the first updates after start. With pm_debug_messages enabled,
the bad cycle shows three wakeups from IRQ 9 within about 0.2 seconds,
the last freeze too short for the CMOS clock to advance, and then
rtc_resume() injecting the UTC offset:

  PM: suspend entry (s2idle)
  rtc rtc0: PM: rtc_suspend returned 0 after 0 usecs
  Timekeeping suspended for 1618.173 seconds
  PM: Triggering wakeup from IRQ 9
  ACPI: EC: ACPI EC work flushed
  PM: Triggering wakeup from IRQ 9
  PM: Triggering wakeup from IRQ 9
  ACPI: EC: ACPI EC work flushed
  ACPI: EC: 0 stale EC events cleared
  Timekeeping suspended for 7200.407 seconds
  rtc rtc0: PM: rtc_resume returned 0 after 1490 usecs
  PM: suspend exit

In the normal cycles there is a single wakeup and rtc_resume returns
after 0 usecs. The extra wakeups are EC events from opening the lid.
They became more frequent here after I shortened the resume delay of
the Samsung EC quirk (ec_event_clearing=query and ec_delay=100 set at
runtime), and that is when I first saw the jump.

Your analysis matches what I found reading v7.3.3: rtc_suspend()
returns early because of the persistent clock, so old_rtc and
old_system are still zero when rtc_resume() runs.

I have not tested the patch itself. Keeping the RTC in UTC hides the
problem here.

The analysis and this mail were drafted with the help of an AI
assistant; the logs are from my own laptop.

Thanks,
Ivaylo
