Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5B430CD1
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450218; cv=none; b=VO8OCWuc4bBVEfS09vzkxBLpVr6OQMFXiZnYmue2ziZIzKMm1jSolxzPqkSNStJzRbvY+o7+U7uqnJSwpnmHV9FxJJsCz+yxnZ7gKDs4tntaP4INvDaJFTFMGp5Vbt0x3H5vtzOKGyyR8KOKhEMpy6/r1DAUlfI7CyU8mLdyKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450218; c=relaxed/simple;
	bh=M0klPbpMKSDb83aeDRUr2B8G3YjIwJhy28xYU7z8QLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEFGMHCs0lm9ms2/ITnxNudGpUqmrcWq23uV2UlaClc32PQA4caSQZA5tWbEeDN0AzqPbXxOP9+E5NQla+Nn558NnvmT03ujfvl1XuWA3RLHB81uu457pHupBYBnTJvMyy52bfnkCrRMfGylybOvZ+gB9hLA528U+XImDLOIyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3zRSSBr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3zRSSBr"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec201b582so3146722e87.1
        for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786450214; x=1787055014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJUUpA+u/X+Mw8WGuh26FuT0SdK7L1t8Py4ith47VDM=;
        b=A3zRSSBriVNhHHC0kVcqmyAKY5sdk+rlxwdl6FoVzDAPXcv1S/a+Dss3LK3UsxT+pQ
         T0w7R5AncVRO/FaiyZ73sIrs4MqwjE41wc6k1tV5CdHjzmHH2MCvRfl73osAoeorSs04
         91iHNga5qv4xsU3hOP15zTI7piojNLwi9K0C4lK8m4Mx0VDmrWpmDHS9X5D3/Sszp2NK
         XDNIr3IdCMfaPpAAK7DKf4GubNZz+pRqksYeMF9gMiz2LiG+t9yW1nCftAH1Wph316Tp
         iT6l1X948JRzDe5H+ayWnZmrpSe/LqFQwOPwp7Sorq5tJgHDxfNm63egnIzVnSgYVmcV
         0QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450214; x=1787055014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJUUpA+u/X+Mw8WGuh26FuT0SdK7L1t8Py4ith47VDM=;
        b=K1o0OYb+nOzhW9cTdb7x8dF/fhRk0JeOgYQIoje9eW0V8E2ggd7Wlw7NG+rZpEBWYl
         r3zBKlz925/o+W8GDG/set3Tb9pUZQN3Kv7CJIp4wuE09kW8wPBKD5ekmDwztbBd9bw6
         g0cL8aTRS4ycdWYpvNh3mVPfrQcVktQ2OhQmBJ41IxgFxhj2rn3uKnPR1Z5aQmkBfbTR
         qaee9aIGfu4bOL/RryZ0sg+VLxTg9hW6EYIEZg62hoPg0dRve4kV5w2bBIiaVF+5ZlPy
         3bJActriTASEpNybfED2QnBuACn2NaLJCccBVRUB6evICGkilxTll1gLMpkPYvor2RJB
         NPpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2zXLchpHS05D8vOkf8LuKYZEu7hCHpo+HAg35jLbVmEstc+uERkxFjwmJpLPpdAxnN/ka1DMlh5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaYwZDLhCKTtEAD5SdWsn/Y8DR3SZQiXN4BGVxgzeIJu/JRdX
	8NSN535w78mVxAmQoJ1r1F2GsouDJHoDNTOLYXK4EgmeO9+yJnJ4cpJZ
X-Gm-Gg: AR+sD132nBliIMFfgJyraAikcbpjLpf9RMBjBvEbkSCeCVWmlhQGw7H1RjIe066v81N
	qjDCAmJud7/NvRyNqxLOYQNpZa8ekm5v95JYXvUjJzpZ8OoADDUFzI1atQihHKnNSopInfh9oDp
	uj5aGAGXE6HXdY/Zy4/Z3fVnuZKAdPqdZmXwerkF2E+2Bdqt+qs9VFMa4QdlCeOFpU0ns/7Ze+E
	E1jPZBDgZuK8XLtQdG+AInnIbtQmtgafFnAaDtiVsz4e7c8kB5WY0X9z8HpbyFitXarnTbjAEMC
	dBuFF2jydBUDbYG3SQGNfNlOWy9RKow4O2nQE6R7VWIE5ph1tYKfPM+7rP5cdYfBXFCiQRIZUks
	P/fkfngOr8XHKEfa/V2sGsm17TQpgVCU/3lqd/Ff02jkBdvjbLlFzj0wxB/m5Y8dridLaVnXQyg
	8CTJVndN2t1jFKe3byLDoGVWo8xh7w6c2my6XN/zFV/sReXj7rIReCYB5im6/c3bmyqznIuzY=
X-Received: by 2002:a05:6512:12cc:b0:5b0:1b78:4962 with SMTP id 2adb3069b0e04-5b44866ef23mr489653e87.50.1786450213825;
        Tue, 11 Aug 2026 05:10:13 -0700 (PDT)
Received: from hekasnap ([2a00:fd01:82a4:d100:739c:a0f5:97b3:63a7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4486c0a14sm238919e87.1.2026.08.11.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:10:13 -0700 (PDT)
From: Troels Vognbjerg <hekatombe@gmail.com>
To: kamal.wadhwa@oss.qualcomm.com
Cc: alexandre.belloni@bootlin.com,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	raryan@qti.qualcomm.com,
	robh@kernel.org
Subject: re: [PATCH 0/2] rtc: Add Qualcomm PMIC RTC-GLINK support for Glymur
Date: Tue, 11 Aug 2026 14:10:12 +0200
Message-ID: <20260811121012.7046-1-hekatombe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com> wrote on Fri, 07 Aug 2026 02:26:29 +0530:
> On some targets like Glymur, the permission for receving the RTC
> alarms is routed to charger firmware running on remote subsystem.
> 
> This is because Glymur boards have to  support MSFT's `TAD feature`
> on the windows OS devices.
> 
> So rtc-pm8xxx.c driver cannot recieve RTC alarm IRQs via SPMI on
> Glymur. So in order to make the IRQ available on the Linux kernel,
> the PMIC RTC Alarm IRQ must be routed to APPS via remote subsystem.
> 
> To implement this, add support for a New Qualcomm PMIC GLINK RTC
> client, which will request for RTC set/get calls for time/alarm IRQ
>  via the existing pmic_glink interface to the charger firmware.
> 
> Also, add a DT property to explicily support enabling the RTC
> writes, keep RTC writes disabled by default to align behaviour
> with the existing rtc-pm8xxx.c driver.

You mentioned this patch series applies to targets like Glymur. Does that include
the ASUS Zenbook A16 UX3607OA, or did ASUS do something different on this
laptop?

The reason I am asking is because when I build this as a kernel module,
I get the following error message:
[    2.241461] rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx failed with error -2
[    2.499556] Modules linked in: rtc_pm8xxx aes_ce_blk ghash_ce gf128mul sm4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 qcom_battmgr rtc_qcom_glink(+) simple_bridge display_connector
[    3.277788] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[    4.318666] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[    4.319085] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: registered as rtc0
[    5.359404] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[    6.400331] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[    6.400496] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: hctosys: unable to read the hardware clock
[   25.447761] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[   26.488271] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[   27.517573] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[   28.560114] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[   29.609224] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[   30.638629] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[   31.677524] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[   32.720749] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[   33.757662] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
[   34.808360] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
[   35.837651] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back

And the error message keeps repeating every second or so.

--
Troels Vognbjerg
