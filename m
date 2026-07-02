Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F03CFF4C
	for <linux-rtc@vger.kernel.org>; Thu,  2 Jul 2026 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036780; cv=none; b=l7ogPFIoEcIZD2ll7wb6TWZ/DELXT1l8js4iQl2EFb6lvJyfb8LZS/cwvf5eapO7F0U4jzoxeo8Dk7V4Dr1oVEI5DH8x6pCiCX4uOdiDg+W7M6WMSDAkKosaBKMP57C5a068/c00ASghWJRhAZwJUf0eWGvf5BPxpNNbfFyMoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036780; c=relaxed/simple;
	bh=JOwGgtvRFkNXTxMbi3iDupBuhlGFDkBzBNbmLzqbltY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV9zq1Z5prorAApTR9cyBdKiF1dNALtFdc9YetWOlPfY/wHuyy59I2JmwamCyT8DOLbzVQIb3cJa4fEipaWa3nqsVCVDEI7+eJyzbLMDqWFdk4T4mGmn2SanTn2eeFBfXxZvhido2ut/7ULGAkLtiBJnGr0BJHYG+/q0EWWJ8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLob7MPD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLob7MPD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efcef23d21so15444896d6.2
        for <linux-rtc@vger.kernel.org>; Thu, 02 Jul 2026 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036778; x=1783641578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOwGgtvRFkNXTxMbi3iDupBuhlGFDkBzBNbmLzqbltY=;
        b=hLob7MPDlyxB5As7RCVODmthCYSCN7WUhaHV091junaE0FObybGdARXa0erC9yhwNK
         Dsbq91nrRaz7PsoBTs+N8eZ6M920fwe9cua2aSXlrraaxzmI2tooVWSAQAqm0ZWxxsyy
         vvoLxzIFeMyCWtepN01LDheM7EPCA/hSE1qSFQFqOVmTTmYUnsvCMRSJnVzKDaL4f6jK
         om+wB1U1ut9cp4qOvzAZdkIh/47haj02w2oot9KiQIhUp1zKosDZfSVIvuNFiwLbFFiW
         AfBGBHbRxVDqmuHmjdeVni/bm/Q4UGlal3ZvCFmptBPQOVpfkdc9oTqkbWX+QDQYsSQu
         9msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036778; x=1783641578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOwGgtvRFkNXTxMbi3iDupBuhlGFDkBzBNbmLzqbltY=;
        b=cAsiHzA7jYcq4nhHqzGQxSdqSESshz1/CM3gP0RE+kUOXs0NFpfJ/UYMmivnSNmMG6
         0TjTvU7Hc/1C16T2PZvGuGhGMUkVbKV48M4IHqMknc3g201uk/2rxbJEgfiPYyqGMfUt
         Q1HOYhpg25SFEbM97A8DVhaPQktb55mFZI2vzqjaRt7DWtbp1WEfJoXdU39BifFKL3ZA
         ZIVra4vxZB8kbN9j/zIfTgHKUlLe+TfPDqPseNsiec25FaciAcCVQg6AThKcjcRgGsTf
         C+KQzgvJnEh3qQfdt6nAdr5X0Fn7+0XwsgLWo1s4fesxyxWLsIxtW1L5fOJ6kak7zPO7
         tsGw==
X-Forwarded-Encrypted: i=1; AHgh+RrOAmu1J5xqTJD7Q/trkLpAb3cFrHNBdmEkMwRjWbwBUE62rFZteRB0DnzELpe5/Sd8hEjRG+N73L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cKZYqldt8R5e4+0lS0Ne/ZAu7yshZI78d/GTdVsGjNyvnZXb
	0+BGKRKEIYdwMeCJseToR/JAtKyZMq/acQ+XHWzn+c7xe9ip8oq2KQgr
X-Gm-Gg: AfdE7cnm716OkECCB2+2V+frE/yvhDisOkh2NWUCK6tqP0t69BNoaUuusN+UhqIIMWj
	GSFwK4pkpJkmubECE7rJlxxUXUWYoDfn6jOC6XW0ZaiyYWvKLfYlL05QBjpz13Ag+9LqRe+VO79
	RD2RrzxXOqnsii8+z/cCmUMDpg7HOwrHqS1BhkhUQa7SrdctQ8hsE+y60Ma27dqdarKgbhMnw8N
	7wiZQ7PHELMpKdwvksLwU9obg6z0hYkPZpueYe4lcm60w0sJL7mALrcaEtIbNs/iE5qPxXlDOMs
	k0a+yGK0MFgnlltlNNGvRm+gwI75LXSBSlDBuA/17X+RQRNMIOr4pj0XaQyeJChtM39vce2QBbY
	7fNl8/vt7OTxGmKFJL7Lbqf/n06PSW9LgTyePzM5pNanMBz5ljyYy2UUEqILtUqzVgYK4RnJVGm
	I0M79ZkPR+eHDqcYFtTyed0WTs1smE/30M9Xlqt9UCjtA5bbAInr/Pz0hO0qqPg9UUn6TppPY=
X-Received: by 2002:a05:6214:c6:b0:8e9:e48b:9571 with SMTP id 6a1803df08f44-8f3c8ffa8cdmr94354126d6.41.1783036778419;
        Thu, 02 Jul 2026 16:59:38 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f306123sm46180846d6.20.2026.07.02.16.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:59:37 -0700 (PDT)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/8] clk: sun6i-rtc: Add support for Allwinner A733 SoC
Date: Thu,  2 Jul 2026 19:59:36 -0400
Message-ID: <20260702235936.1231945-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jerome,

I gave v3 a spin on a Radxa Cubie A7S here: it applied cleanly to my
local A733 stack, the RTC probes as rtc0, hwclock set and read-back
work, and the oscillator tree in clk_summary looks as expected. If
there are specific checks that would save you time for this or a
future revision, tell me what you would like exercised and I will
report back.

For transparency, the test harness is AI-assisted (Claude Code) and
results are verified against the captured serial logs.

Thanks,
Enzo
