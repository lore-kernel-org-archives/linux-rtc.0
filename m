Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AA3C872B
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686745; cv=pass; b=KsYCLhxeh1xaPKpqI1cXZRdjhQFxqsGq/5fEN5K4BXsUv/NsqmTK0UMw9rdIyNbiAOAr/16OC7U1hB27OjGAB0X3KPpxCrWcxu/AqoWe7VBNxLTffdzQzmvaYrNM3YLyPxF4EjmMT5AuTS2vp5hq2K2725QNXwk2h+sI/OW13bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686745; c=relaxed/simple;
	bh=wgf3EEkFlzf+G6IdltrSynW+0EZc5Ur1qA++WoxIUPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbkYMsmC/sbnyvuDxRQspZfQuvLcUP4+a+Rk/20zvxbSjMZ3iR9CMntkJSuCEatNsIkOBVnqhcSWvZ/YxGy7Unim4FjvEfm/ylVBAPLRR0ulriBg0T5fzElPb0/KhNcu0IbKqzqktBN+rLGIGNWcTp/aUbN6FEOQXu4nDtRcmxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPQfQbNy; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPQfQbNy"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so98448e87.3
        for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 12:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787686741; cv=none;
        d=google.com; s=arc-20260327;
        b=oHpvrCsNkZs/Te2J4RAdJrvl1BQGC8GnvGuRvCnOzFbUux4QZUTSwDQYpXp0o6fC1P
         9cwV0hVL5amVuVkwEI3bByWMShi+AJ+JN4jy/DQnFNc9okkWTgQRdN74cSvQhmIBzl3z
         aUbKf+cdV4zaUeRQmNPqvZHwoaU1eaK8duuPCUhzWhhLlWWHxBf5yDRQexa5OfOVNA3J
         pwKFr/Q4+SOrJF1DQ0vqeXhiVQ2239MHkaLk5IG8CZm+8NMtdgNkEEYnVcvqPAE9oiMI
         K5NGgNGRvwHnkdLTRg5yYSseQkbZzBcQrs/K8Sy/AjqewI4DeaG9VR3erxpl3Yin76jc
         PyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8ogUiHTu0eFI0J8r+4KzxzBHNBTHluLzoqKdtSeUpls=;
        fh=H3SNcvrqXN0m8BZp1TDWF3HBPy1PzSVuqPMiTmFW9Ls=;
        b=qWC0xliv3mjIlW6g4Ja+Z74Y8t3swfm1KiN18yokJSCAKk/IxjPkfoWby6lOFhbGnw
         D4BCMAxIvfgnYCdBm14IvhUUgpJRu7h9GUTEREvKFcDYtKfSrkSTiORwoCPLkX3RF/MW
         3XDMF2kfgD2EuzznatXjj0CSKgQeqeHJTRMuRColoY0NGBxv+CFVPKx4n6XKdD1DMHuE
         ANVP/LI26FHh2vVXN3Pw/72SMjWDz8sNAYL/FQO+Mpym/tZu5XqU5Ap8manxhL8mutdZ
         nPxhpwZvEoar9hcNjsmdEmu9oQDjV79QkVmTa8QH4a5TOQ8dusqRG/kaJ7UbR2KC2kqJ
         XYSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686741; x=1788291541; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ogUiHTu0eFI0J8r+4KzxzBHNBTHluLzoqKdtSeUpls=;
        b=EPQfQbNyOWwH0PJjTC2qhLGiI+FhXGrXFny+RgzOzmQ+Y3cyaHKE5JMlVrinYU1vC4
         KNOSgip9gOIdncTQRnU36C0Mqri1gpxEJJItVvQSRP07ty70en6UH9UreFbA7gkC8Pce
         Q+DCIXmxsJEaoLc4jKVngikCoeKabsLXvMqy9WOwO0OcR7nut//IaVq8tDCld92dv6Bi
         Vk+SNy6K2JFwTG5rI7Ez1nBJMt/8OhNiiWAg/HeoiEyYGswloq1SvkbtT6lCDIdK4ZGp
         WvR9rJisPQaD/YphEvXoc/iAu+qMXM3eGb3xMq0lI7wNt8Z+eJ8cxm5/YjIf3gC2b5zN
         tzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686741; x=1788291541;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ogUiHTu0eFI0J8r+4KzxzBHNBTHluLzoqKdtSeUpls=;
        b=PT9qMPH+XgR5l9R2PiObZOprEXh3NS3ghTDjW9NNRiex+Hy28RkealnHe+4DU5YVyn
         7F2XK+iLrHDTUpkRmqVEsuvbBhU3R9JT4/EOoEYErlqxJg3C0Ldvz7m8UWdbwCYSq36Z
         9AKdjbN+uI+znI0ebjeHTxVNlWUZ6LNTEKg/C7505y1EThUqjRmpDzX991IJO8pX2/+d
         iehaSI8g0QGkgz36uyRCfabXIX/9yZvA6d9Djeyvt1EDodmWCP5ao34SptX1jFn511Ze
         Lr2Z44DmRAFP1p727nsWVKtVYg9FkM6bDNoMzVajzM3hdn38GfmeeyX3lX5pEOruAUe1
         5Jog==
X-Forwarded-Encrypted: i=1; AHgh+RomiowhwDjMkltMpGAFFJP5XyOUfcK3TgsI/MyZty8H+Ro5t2NC4u3i0ydt64J90s0066HxOsICJt0=@vger.kernel.org
X-Gm-Message-State: AFuF++nA6gcXNGlCF1HDtRaL8zhWbU5Ao4aFIlRYmWRfug/m/F5IaUsi
	nQZjcv8YS0J5d4Uq81pv1iTisbgwC3PX1X5vtGMPyfMOl67voy6zGyT9L3XiUMDpaWb8avfltAf
	AJu7kxZUAmVLJ+argEw515cz7nTHCwMe3+WhjlRivqQ==
X-Gm-Gg: AR+sD12kUka+KhIAMQI1HJOV1vvT6p09+FMBBVRleenlN7DHbrTMd+RdO+vSvyfGTnT
	iT3mMA1KfaplKFI79TDKprls0gutiN8tF5eCn94X/K7cU3pG8BkvrXDEFTLhCo1oFa3z4EjA4oB
	3l2z2oO7cizgzbf6/j1CsS9NAm3CHgrfCUlZ/nZRnrUx2cvi9m2MQpQu4F1RrYcd0/Jo+YqeL2i
	JKZNiPM4pvIw8l0z3oelPHTuBCprGlAa09MAd+7aYp5r+LXRPNySn9UdolRvwZ6dqbLSLDgL2Xt
	Q2myolNr72PzPV8ZbbtjNtwSis6dgLwU+W15C3Q3nzXAAkaSVXrXvJYkgv3C0YYznxvaDQnPKlH
	QOg==
X-Received: by 2002:a05:6512:800d:10b0:5b4:a2ec:c078 with SMTP id
 2adb3069b0e04-5b4a90634e2mr132019e87.21.1787686741212; Tue, 25 Aug 2026
 12:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260811121012.7046-1-hekatombe@gmail.com> <hb3jvyuf2j6sl7pjimnccoj4hsmqtxdq6s7w626sbmpbcqw7t3@wzyo563dmcle>
In-Reply-To: <hb3jvyuf2j6sl7pjimnccoj4hsmqtxdq6s7w626sbmpbcqw7t3@wzyo563dmcle>
From: Troels Vognbjerg <hekatombe@gmail.com>
Date: Tue, 25 Aug 2026 21:38:49 +0200
X-Gm-Features: AcwNN1VZcKL5ZYQ8eFKgbPi5mRCnrneKZXfFkqke67BVsou1ADgT2iiGjFFRt6Q
Message-ID: <CAPMyOuBXBS+zOEbNHk-TRTG43RPcXPpZLtmpHka-WDzATC8nzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rtc: Add Qualcomm PMIC RTC-GLINK support for Glymur
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: alexandre.belloni@bootlin.com, andersson@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, raryan@qti.qualcomm.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 18:38, Kamal Wadhwa
<kamal.wadhwa@oss.qualcomm.com> wrote:
>
> On Tue, Aug 11, 2026 at 02:10:12PM +0200, Troels Vognbjerg wrote:
> > Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com> wrote on Fri, 07 Aug 2026 02:26:29 +0530:
> > > On some targets like Glymur, the permission for receving the RTC
> > > alarms is routed to charger firmware running on remote subsystem.
> > >
> > > This is because Glymur boards have to  support MSFT's `TAD feature`
> > > on the windows OS devices.
> > >
> > > So rtc-pm8xxx.c driver cannot recieve RTC alarm IRQs via SPMI on
> > > Glymur. So in order to make the IRQ available on the Linux kernel,
> > > the PMIC RTC Alarm IRQ must be routed to APPS via remote subsystem.
> > >
> > > To implement this, add support for a New Qualcomm PMIC GLINK RTC
> > > client, which will request for RTC set/get calls for time/alarm IRQ
> > >  via the existing pmic_glink interface to the charger firmware.
> > >
> > > Also, add a DT property to explicily support enabling the RTC
> > > writes, keep RTC writes disabled by default to align behaviour
> > > with the existing rtc-pm8xxx.c driver.
> >
> > You mentioned this patch series applies to targets like Glymur. Does that include
> > the ASUS Zenbook A16 UX3607OA, or did ASUS do something different on this
> > laptop?
> >
> > The reason I am asking is because when I build this as a kernel module,
> > I get the following error message:
> > [    2.241461] rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx failed with error -2
>
> This is a different driver error, this is for the one which works on the SPMI bus.
> While the driver that i have posted in the current series is based on pmic_glink interface, which relays the
> RTC alarm requests to charger firmware running in remote processor (which implements the Windows TAD feature)
>
> do you have this `qcom,no-alarm` prop defined?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/glymur-crd.dtsi?h=v7.2#n565

Yes. I used the DTS for the Asus
A16.https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/glymur-asus-zenbook-a16-ux3607oa.dts#n863&pmk8850_rtc
{
qcom,uefi-rtc-info;
qcom,no-alarm;
};>
> > [    2.499556] Modules linked in: rtc_pm8xxx aes_ce_blk ghash_ce gf128mul sm4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 qcom_battmgr rtc_qcom_glink(+) simple_bridge display_connector
> > [    3.277788] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [    4.318666] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [    4.319085] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: registered as rtc0
> > [    5.359404] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [    6.400331] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [    6.400496] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: hctosys: unable to read the hardware clock
> > [   25.447761] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [   26.488271] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [   27.517573] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [   28.560114] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [   29.609224] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [   30.638629] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [   31.677524] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [   32.720749] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [   33.757662] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> > [   34.808360] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> > [   35.837651] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> >
> > And the error message keeps repeating every second or so.
>
> Sorry for this, i think the firmware needs to be updated for this feature, I will fix this by existing cleanly
> if the firmware doesnt support it. To avoid repeated messages.
>
> Also will check internally how you can get new firmware (if you want to use it?)
Again, I am on the Asus A16. I think I better wait for Asus to the update.

> Again sorry for the trouble.
>
> >
> > --
> > Troels Vognbjerg
>
> Regards,
> Kamal

-- 
Troels Vognbjerg
