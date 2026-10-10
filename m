Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505ED33438F;
	Sat, 10 Oct 2026 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791605094; cv=pass; b=WbWNoF1DEturKD+iMrun5EzkqaaYTHpRbezR01eMJ3YWQF9Yw7eFWdG2rVUUEZ17RbHE7p8g4P2Qjo/NIys2Pu1FIDDgfViwPVSOORThCJ9hP40KylwI/PoceLBSeDJKfS52Oi2XEazOmJIF0f+2MrGPW7nrrJLbDJBmwbxNeBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791605094; c=relaxed/simple;
	bh=CeiPB1g+eDByoXXC1SuXUTzr/qthsow56+fantnejKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ilx5hvHis2Q7D0eCpHrVUw6Ps8EoSQ9Pq8BYiAPgwMCbEq8T4F1JiHvSC5oqvxTG1Qc7u99ECI/qklTLIDJavj40qZz4EONIvsBpmPiGZxWJ3qDXIy/m7Tmf6Z9sTDHV7ki5JGzYBMBn7tJwNnvFM4R/P4/IQ3qbcDEPsP6eNVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=PtxmiHEE; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="PtxmiHEE"
ARC-Seal: i=1; a=rsa-sha256; t=1791605068; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=K16xBdR9qn3AQORmlvyqHOUZtsle22FySZYyU//mCkNdCNgXBAM6R/lUBjvI6HSh+CY7/mVty21qxbA8LprIXDwKz4KwYPzhOWYJV6NvZitv9xca8F5AOfhjXRLuUxFvF1iZAa4RfxAVw78C2xlJZJ61MYjYKNaod7cMNoR7jC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791605068; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CeiPB1g+eDByoXXC1SuXUTzr/qthsow56+fantnejKM=; 
	b=GcQKVF7yzhFf8/QFfUydgyYoKYzsYDtSy82Lw98J6KoTMDgNMtXnFUJQuV821OwTUo1UnQrW31kDUx49K7NoA9A8ZuiwfAz8RbIfftbFw1DXA2SYxyFM8ceMrivyUUVM5ExYFbQXy8kLTiHpraMEGjVYZc2r5BBdsCOVvEyvgGg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791605068;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CeiPB1g+eDByoXXC1SuXUTzr/qthsow56+fantnejKM=;
	b=PtxmiHEEnqdomU680bKSWbwPY9Ev8/LenfrcHkuzQnzIZ7aWlYkQnO3fnaQ3Eecg
	oHWx1WLlgZiNPK2a5K1KFEz1xp4ZkLihIkAN7lMU7ch5jgc1f/m4Ak+UoLU3heYjh8x
	srXQXkKBEQ+c6DIchpa5xth24qjU16uHUMAup/eM=
Received: by smtp.zoho.eu with SMTPS id 1791605065290202.21768844090047;
	Sat, 10 Oct 2026 06:04:25 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: alarmtimer: no way to choose the RTC on boards with two wakeup RTCs
Date: Sat, 10 Oct 2026 07:04:18 +0300
Message-ID: <179160505804429.3363580.alarmtimer-rtc@iav.lv>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

alarmtimer_rtc_add_device() binds to the first registered RTC that has
RTC_FEATURE_ALARM and a wakeup-capable parent, and keeps it. With two such
RTCs the choice follows probe order: ODROID-N2/N2+ (pcf8563 and meson-vrtc),
ODROID-HC4 with its RTC add-on, and 11 rockchip boards in v7.3 DT with a
hym8563/pcf8563 next to an RK808-family PMIC RTC. On HC4 meson-vrtc wins.

I found no DT property, command-line option or sysfs knob to make the choice
explicit. Is there an intended way? If not, where would such a setting
belong, and under what name?

Igor
