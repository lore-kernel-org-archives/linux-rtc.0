Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517920;
	b=pNw2seG61vjqIk5E6Ws0N/YStch+omc/D44HmTYa4vg5J9CFi7PeKEzuP9tn51MpOEs2
	 0lP9LUr3GKB56fhvjiyylx04naSjWnquluYvoNfqlDiIDC53JG91BcOySGuD2AuqwNo29
	 Yy/VyYPIOnFzMJ/xVMdigzH1vJ9IPlhOJPoqVKeHXBPKz6wKbAHCuFHX+0NJwNlgKhr2R
	 yL3gVxHeLiK6LU1RrJAeo3GnwdFHnUmsAHrOI8nhuWbiBbsaoS2TS4P9n1lf3xPnWx4VM
	 BMMriGzAgnPpCfy876hSU7KLugnL2qMoSS5HEHKbZcywNRqX9bSYGvLSt5uCj/de/QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sw+u/f9GrnCWR6VUs3++RZAN52TxC2uVPXknWSBOLT8=;
	b=c0i1JqVxkWjMVPV4AtViSSwfoxI+HZzojehnv1z0i8IC/lmOjV0aD1tliewOVGZR7cH0
	 74EkaJvvMbk90B4Z2zn3u8eslJ7QuYEchMAOgtILtTcqyXrxiJLFNL6srUXJYwWmLIPvm
	 71S4b0B/1FJPokq6/r6qbuhMXhrKQkj9vWj1alAvcnq52+/Uvi6xrFJMMtCbkgskzxEud
	 7KbklWfgpOMeQRXaY4cf7mKnnXh7yUtXwfPeaPhjIE/51ND1vk0C3w0rahcBsxvMnglrS
	 1KDDZGV69yOPClyy7py0xHRrULEZPDBY3yemkzsLr8Pu0QKDzHnyg47jHn3WFE/fVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M3W0omNR;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3B606A337
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 21:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE3B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M3W0omNR
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6deb848ddd7so234560eaf.0
        for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794517919; x=1795122719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sw+u/f9GrnCWR6VUs3++RZAN52TxC2uVPXknWSBOLT8=;
        b=M3W0omNRHGTbz+A6sy4W4s2FN8ANNH6W/HkJcX8Jmcp4mXz3i3db04Rh5IzyxvmIH/
         29sN+n/uGI7+iZF6hxoR9/97f5a5zuhbhTSSMIRHvquO6nRD+UboUCqaBgyTnIc4dPzQ
         q4Bstw9i/TKMUTQaPmJbqK2MO5zfGHkxVSDdgjCavduFg3W0Ka0BnlrlTordrkmmrIRB
         wxs16YJwBUBJ5vPlwvD/asTNMCWNv84zXpOjzIXfjitiNxbKd7trC0pMwwayCXMC6laL
         OVkdv+h9rA5Ki4TQwf1cohY1XYUivG/yU7S6UtccK5UmDUNs8DeOJOwi2UU6oa2tjhMq
         4CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794517919; x=1795122719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sw+u/f9GrnCWR6VUs3++RZAN52TxC2uVPXknWSBOLT8=;
        b=rWsBQFHZGgH7oNGkIyIXVcUW4Ly8Sp+NtFNWf733L2rJgCzGVDNB1WSfzejnb4IoLW
         LggkfdHFRCDjMXtUbB7avTUZTvYbAsh3IsuYA4RPxxl+yG0oyT/Bqa8itNx+lwRzNUnR
         tL5lI/lVv+TGyYIqvu537WuIhzatQ3MCCxd5eacCmkV6eQ0TbTpAoBSMmnjx1ezQ+nd2
         kcvm2Q/iC46XTG1pPsrROrqciuhQ1xRMstDwh9On8a3X2T9qYomtmTeZuPYFwnZbBfCt
         yo+hfp7afw0lBRTcoW3rcs08xYsEwhhnifewYMF/WiRXcc08XroCDcgqE0uoTqKAjvEC
         5Svw==
X-Forwarded-Encrypted: i=1; AL+hErGsZ7H1ahD62VeKi5gJoA6FRLlYVhp2bps53vy9D1Kpbntr2l2H5y7aknD3inzPHf4lpBMw+pooXDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aDZmVDt6QHGnDABp1+3PJD4OloYsL51rmIEMPHAWCLyVZy50c
	zgyH+7H4ChwidTcgA6uhHH9Oxag736eck9DsMBnCmT7yA7tBbQztZuZB
X-Gm-Gg: AYBFou10QAXNLMPyDVy2fOUajfIgyf8GvaOLtakl4bGNQf9/OpDmfChNeVONzqL0LCy
	3pY6sUbQ7rIqm1HffNcMkSvhDUS6sR6UH7jyrpQmxI6EPL83kchFulIbDHMkca7ltmMqOjj5ExK
	tDYfCEmt3/4gSY4OSDiW/J+TJUjax762ccheI4M04jGYKLxold/UT/8qyLBjxF8SEdbY3rk3lqX
	nvS9usAXRQlQHu2yoM66Ki0T12Lvbrdzg1PfLb541CZPKSpcNzofm/EZa4kBtbXEaYFHvpm51Cm
	J/SWO+DGry8vTW9bGtgliiJyJbZyaoUqNWrb9JFxPkcmaOzTWiJCQfyGNb/aj/oJySoVSdnilfR
	znVWPRj7s0zz7/RW5Uq93Hhz5KYQglV4MNLaoFEduqfVSxdLxhzAmBznJsZKbZaLZVr0NBaUoXK
	IACKplyT7U66jlP/Q/J8Sq9ifIIcROxEbmMFrCfTYegt8d/v81sXgsD5G0VLyul/qDlrfwcJpO+
	WEr4/M1y5jRT93HUciPDMCEiSGMuLlNNk5hjLp9OuCE5Za0DFpQTOCqxYK0h6aXutHO+ptPMLv1
	MnLN1AEMQXW+i/fRNS5TQC5WhOGVxYIiUhjRbKrkF7L5+ds2ogVOpUahgMxGxU3qGlSJKwHRjzk
	=
X-Received: by 2002:a05:6820:3383:20b0:703:8835:5fd5 with SMTP id 006d021491bc7-71ab4f55eb4mr186047eaf.25.1794517918643;
        Thu, 12 Nov 2026 13:11:58 -0800 (PST)
Received: from jeffmr (63-152-14-173.cdrr.qwest.net. [63.152.14.173])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab3f44dc4sm364257eaf.0.2026.11.12.13.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 13:11:58 -0800 (PST)
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
Date: Thu, 12 Nov 2026 15:11:38 -0600
Message-ID: <20261112211138.40217-1-jeff.roach0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9d80c088-1a0e-48fc-9a24-09fa8c281cd7@oss.qualcomm.com>
References: <9d80c088-1a0e-48fc-9a24-09fa8c281cd7@oss.qualcomm.com>
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

On 11/12/2026 3:10 PM, Fenglin Wu wrote:
> Could you try this on your side? If it works there as well, I can
> discuss it with the firmware team and come up with a formal fix when
> pushing next patch.

Tried your diff (pmic_glink_gio_enable_alerts() not called) on the
HP OmniBook X 16 (Mahua). It works:

- UCSI is fine again: no PPM init timeout at boot, and plug/unplug on
  both USB-C ports creates/removes port*-partner as expected.
- Charging works on both ports, and a USB 3 stick enumerates at
  SuperSpeed on both ports.
- RTC via GIO reads correct UTC.

Please disregard the plug/unplug sound problem from my mail yesterday.
With the GIO modules loaded, qcom-battmgr-usb never gets a change
uevent, but the sound works anyway on both ports when the laptop
starts after a long power-off with the charger unplugged. So that
uevent is not what drives it. My guess is the earlier failures came
from leaving the charger plugged in, or from power-offs too short
(about 10 s to 40 s) to reset the charger state between test boots.

Jeff
