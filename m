Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402892;
	b=EdKIevGboemvlASTsPNNT8zmTgclE3Bw1mZkJPEA5If8oqFbH6FssrKGpCtBfjOQdN1a
	 LrvUx3dvI9xVuUPItujQ0ZTrpCjihxDtmGJDY0gocIlAGmtnA/LdGZXx4Nm/XJAD1XerI
	 q5COkxnFAxdDwyDxybUubjlNG6XpBuRE766euGaFqZ/TZkPVr2aBT/YSJ+Ai8Gq1wz0yD
	 D/U0YlAlseurN7sA3vfg1G0GCPPNJNf7Avf0LZQtwAp/QGFZTpG3zzM0zZtRV/dVuNPnb
	 Szc9e/W4e9T9Iz8zfR6cv4prWHv5B+IPxiPoaUsDYe/LVvJKh+UNu0bbI+tNvZv1Mjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WU9tbewfdDNGygX+WsvROhINm1RTKRFNHxU/Ul0rphA=;
	b=vTorhCUfmqYC0lgWLn+gdtvRRNrDPctj0hhwixW2OqvftKOEH8/fzGfN6e2p4YUmtlJA
	 RwdUfO0x2ZlPkLT5RY1DeJ8NDHVF4J87awYtqIdvXHt+57vLoaOnQhvgg6D2ERl1BPzj3
	 0iSsghBPkVmQ/GDmDUP5ColjyG9i6+tg6AeAqBbOSuRx/fzc5977kDowqcaKz++jGqrOf
	 pJ2bhJ0+0hWpBGEKCxG9VmS/Z+z9aJuGMgKJ2v9WPAYTNX+jSLf9LN7ORskrGHloSbwF/
	 BUyUno5T/ZWxlG2qP06JaAt2lCG4q+s42EzkUvznY1uGR9DYc7hr78a6NcKqzM+j9Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS+OZ+8l;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19C606A326
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC19C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS+OZ+8l
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aa9606ddadso1810723eaf.0
        for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794402891; x=1795007691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WU9tbewfdDNGygX+WsvROhINm1RTKRFNHxU/Ul0rphA=;
        b=qS+OZ+8l5x0OUYgVDcIkSVxv7Vxi8PNBKwee4x8AXelL/5+qr2Pr4Fg+UQfFw8l1rj
         No55kaqFI71remSSwh8C0sIWEmcRXLn/LgJJ8lpGzDPnaJ/5WcocsKojdgzmaa8lHvHd
         HQs2czIVCMURudA3gIXJ9vsP2VOZl0vZkzTqQQoaBmWWzwM574avQsLeQej92E4jBIeK
         o/tBVm9WAiwxh/6YuHMR25V/owmTOwmrZYG0gAMJRMI7R0389sw789bnXVCewsgvem5b
         uEApyHKz8LT0KTVR8oTw0vc6jNNTx0qwaCt0x5PcX0soUkxaXY9G9iXg3IrDp/yvIV0j
         97/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402891; x=1795007691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WU9tbewfdDNGygX+WsvROhINm1RTKRFNHxU/Ul0rphA=;
        b=Gvdlr8k4rmktm5n5Ar+1Mip61LHg+RUDR/xadOcTvuarBkvPNMnHfedbzEz8zGARJt
         WCUVDgSdu011I29vk7z0X3DXebcOTLrxhSHzk/whUU8goEfqiEcFOnBN759ouBblnfXf
         UKxGleQlKn9oSsqxu3hTPSKxSd4AlKh0A0vrHmXoEw+9P+IZhOS6SCKXzOW+soSLp6vn
         MaTQrqjXf2pzNQhrvFcEVuJ+76Sh6zVzbI5nny5SqvPEAbEB2SUGLhpLfZUlFywj1WOV
         qRyh15oNKZgFOMFMjz65MKfw+Oqrn0SF7H5Tv/uOLmH9RQb1VCY5Sm0RY++IiRwFqkp5
         HIyw==
X-Forwarded-Encrypted: i=1; AL+hErGk35bpPqk06MyWBI1U5IA2RyBYhuPAoq3D4hXpwd2B1x4QSi512x7Jafm9TLYyO5zD2A6fKQca2qU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bTE9KiQY2yUh4VWLbDhVYUCXmEMkKSRuxhOGEsLq0IHriJEJb
	lsGiwYdDxsFcXC2WsypW/8dDxp5f+LGAo1yxBn7l4Dgp0K4JcJYnVHNJIXtR/KAE
X-Gm-Gg: AYBFou0rw6w7tJPVKovG1eDG3X2psrqNzecciX3lLK9SIpKsHQY+sTNt9m7o9nfs0Wy
	FYUO6VeYoXZlthXM0tShshfp8OV7hSQ/6ny3JMTsCet+WvglapfwQcFrk1cs+VgWKc3dXfXVUh+
	y/V/z21RFSdaEfMWZe2A1g5n9FZ5M5j351lNyexHNtPfpY+H+F1Rc9V051whbqM2gg+aXcOWvok
	PEDB17QM051A2pTX074Rt14dA6AaxoftaJQ3nY0VuGniNlJCJe0AkMnzSK8vt1qH/mPa0wVZMmQ
	mMQ7fubTBvlFvcNSx4m9dnCeHZT2qmdcVt811TORctAcCYwR90UpTtfR4c+a4x8BsujwjhOfsHp
	1huXhsA3T2Un0u563DxMR6XzYm/w0p/Ui55xoEz+QgW7bq3AIS5moCG+VWdNk+HALvhrD2vFmPF
	/QcFoJ+NQyinE/ZYoiF8ZHewN2RH/8VCbBTeWpx4ghb1kmZAb9ihYZB5qYdtYfqRB0Mlco56RSC
	HncTQM8vTfcj8HHvJsinog1/VEI3ANazyoldlzeOGM4QilEqxCaeaRX96ip6shnM4uTyZPLSPzN
	CTKxQltkKJ5Yg0vC1lzvXt5vLQhDCVm8T/hsSD+QnhouRNWH6Y82TJGMI5Kr6MQlyM0zBHHDSN0
	=
X-Received: by 2002:a05:6820:c0db:10b0:716:f44b:2dd3 with SMTP id 006d021491bc7-719178602d7mr969188eaf.21.1794402890659;
        Wed, 11 Nov 2026 05:14:50 -0800 (PST)
Received: from jeffmr (63-152-14-173.cdrr.qwest.net. [63.152.14.173])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm3602123fac.9.2026.11.11.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:14:50 -0800 (PST)
From: Jeff Roach <jeff.roach0@gmail.com>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink instance
Date: Wed, 11 Nov 2026 07:14:24 -0600
Message-ID: <20261111131424.51869-1-jeff.roach0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110-gio-framework-rtc-driver-2026-10-12-v1-2-e4164178183a@oss.qualcomm.com>
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-2-e4164178183a@oss.qualcomm.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fenglin,

I tried this series on an HP OmniBook X 16 (X2 Elite "Mahua", DT boot,
qcom,glymur-pmic-glink, 7.3-based kernel, firmware F.04). The RTC part
works: rtc-qcom-gio reads the correct UTC time.

But UCSI breaks when pmic_glink_gio is bound, although the commit
message says ucsi stays on the legacy interface:

- pmic_glink_gio loaded at boot: ucsi_glink fails with
  "error -ETIMEDOUT: PPM init failed", no typec ports.
- pmic_glink_gio blacklisted (patched pmic_glink still loaded): typec
  ports and partners come up, plug/unplug is seen.
- Same boot, then modprobe pmic_glink_gio: the RTC works and the ports
  stay, but UCSI no longer sees any plug or unplug (old partners stay).
  USB data and charging still work.

Happy to test a fix.

Jeff
