Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404496;
	b=xeyh+4b8qpyHYtIDOGnx1LSnLorc+J81O16JkZKQI5UIHAUSjG2CwjWqUb7lt94wbtXU
	 Rfzhgt2TCQwsAWlDyjZFHV9SGEwYOsReu+8GDQRZG9aU3XBuWZKCXi9SKCWOSjlTEgH/6
	 pGGYxjbTsEvpmawXG1A81PcL4krxAp3tGBZdkjH/zX6UUjFb7OyF1h5ZVtvfIXlAVpjm4
	 An55zgB7BP+So55Stnv8DSLfLbT0tJicxl2EimopEqOAvxWq+tuOG1nPgRYe6VQBYs+EO
	 WwMC+kAruzVUUPaVVLDCElcklCwT4Eyd3ZjtFSr4IMYLyxDkcGGcKkOQFQQCiNIt7Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tgcyXRom+DYUOBHj/B31scavrv/8OCK7JtPppDaBX+M=;
	b=mHz9G7oSX2aYcMxoNjHHoJZGHPeh+13HOjuTp3GvA2pJfqilPwFtxdm68gWBZZn+Lr3P
	 GotbBNLMiWGH6i2Cjb9bNjfXnjByOSWckOXWGerTIfmmT8PpPtn/a5DSchb9eOOZdcyd2
	 WdzJNafjLEdSwU/WsML6MaR/R0ZCowo9VUA0QulfT2Pf8mvhcq4Gz2nXy//huvW9lFdkE
	 3eiD9z8Mxz5KmvakfEC/ZUGeQVtUsmXOkrIOAhYg+h6+9d8BuXjWJGgL+gv8xM7Lafdlf
	 ZQTrpsux/MRNYvJU91IoJZ4GCeYbkrHvHbhj1DgbnvZBKMa4tQvn6CIvUNkxMZ68r3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F2M43Q5h;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FD606A32D
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61FD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F2M43Q5h
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4adea5b7a2fso1411236fac.2
        for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794404495; x=1795009295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tgcyXRom+DYUOBHj/B31scavrv/8OCK7JtPppDaBX+M=;
        b=F2M43Q5hBJqtm2Z8XTdPEPr3gXFWQKX57WO91E8JYaXNf8lFx6xv482WviotB9saBF
         Fk+pOxkRYsN41HIKHasxbMsR7hGp9UKInskQMg3dj/B5EReUx5meqbv8GAPATba1xkzj
         U2usazsmFAsfu4tkfuq5XgEqVgxmLq0/7SYCvDclv2kJg6nO/F/eAa3nLqJ1z0utVWPR
         vqYVl5i9ccwHZ6kQoiqvCqzLlaywgPJkcKZmF+yudB5MxXUZ0KhcDomdVJJEXcBN1Bri
         LtbtJ1+br4+ExfFu/N41ytzS/8Afdlw5bpVE/1d0zOK1m0wDf6cmPF3mOMF0s/E05sVj
         46/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404495; x=1795009295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tgcyXRom+DYUOBHj/B31scavrv/8OCK7JtPppDaBX+M=;
        b=Uo7fs1zOQlIvECQ0VCYWX91R3iqeEjKmyr1Afxl2wWquc20Wf1VU/aMY5nAj6LR7kI
         KEr/wKFEzKu6z+JxPwhr7b38QUy6rw14Z6e/GYYMZEliWlVonXtzk6xf1ydtv++ogBTo
         Uti/WfZ2Xsb/fLokyiwO5FNVaPCq0MlkgMMa04lxMjD+SGNw8FfcXBse2NU4rhmwX3PK
         cSTxAkyTl09A1HMgwGo9bH/i2JdvydLFjLqEcV+sObX4JSFAY2LaeBzfkTvX6vkydIwm
         j+Nu3RguywvfkzNcwNfXMJcamJB2Pnv+1vlW0RoHBCofNnBrgslFUTuQDax0mVD/StgN
         Wcmw==
X-Forwarded-Encrypted: i=1; AL+hErGd9B2iDYpdiJEzMY6TPalLN/T/34sB0ck5VVXW208TKi9mQZf4H/x0J+aaCsRNvuKRFqUR9iai3+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N55KFBRQ/+GE3g3tqsyQnkR6b+DibJ7Wh+m3yIiHukAbonqm2
	9Up7itKaB95SKvqgAUeCIPb1wBf/OxbUcnl6rRQ9KBfTpChf6apXrTZR
X-Gm-Gg: AYBFou3p46GPFk3ogZ73qE+iu++f6/FwWDEaWU/BsTk/Qbz9ZSo/1Z0ulVr1pRpIlID
	nmGpf+tCXtao80Pi5REL3nN0oXO0CnCjIqyZJu7LNtZDfpysxe4n4hUDQE+85YvOq3MYeKuolxO
	e8YMIsbsaLQ0YdGHyHLved5Ydt4JgqVxA7bgI2VroISLVZBI2COTzw4DfOPC1gXjNng/eeBTDlE
	ZBoWy+DQZ0KhKR/MuYCQlWl8aMFNwme2DnhdF5FTAybTtmY9qNUW1RrGR1OYkrSUfXXpiI7aXw8
	7wZ0w4VmbAvikHpO751bS9n11azUSr2j6ychyX8sL2UJp3oW8TNZCzqP7c2xaGPJds3ewVLeypE
	kl8i/99GCbImN9EAdE0VDCP1K+OulDYdDvW6cwzojAHi3mgpspWWqibipIGfIDI0lrGds5V9YQ+
	Ft5BeJpSvmPuHZ4BiTTD8XKFdSiso/0L2OryNG7Y37lOsecrpFu2RrlMLiv+tEJGmuqb6WmZLns
	7emAUIzKfUoYle8Ed8Fmgc1laB0Gdx5XESTXQavtxFbPQAPvpoJdzP1WiXes2rZWCYwu47BZNuc
	EiVQNBGcJXgra5LxDgjK44Rw6A9A3iOBr29DdgxBHl/dUBg8DJr7FnpX0Uslsm9xpLfgAzoUO3k
	=
X-Received: by 2002:a05:6870:ab8f:b0:494:7af4:954a with SMTP id 586e51a60fabf-4ae46848ac6mr2154035fac.8.1794404494609;
        Wed, 11 Nov 2026 05:41:34 -0800 (PST)
Received: from jeffmr (63-152-14-173.cdrr.qwest.net. [63.152.14.173])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fc1041sm3410611fac.7.2026.11.11.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:41:34 -0800 (PST)
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
Date: Wed, 11 Nov 2026 07:41:01 -0600
Message-ID: <20261111134101.15019-1-jeff.roach0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111131424.51869-1-jeff.roach0@gmail.com>
References: <20261111131424.51869-1-jeff.roach0@gmail.com>
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

One more thing I noticed: after the GIO test, qcom-battmgr-usb stopped
getting uevents on charger plug/unplug (sysfs "online" still changed,
but no USB property notification seemed to arrive), so the desktop
plug/unplug sound was gone. It stayed broken after unloading the GIO
modules and a warm reboot into the stock pmic_glink. A full power-off
fixed it.

Jeff
