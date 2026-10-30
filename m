Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357453;
	b=pTByouK6KOVkOWgh3oHfBXQv7ZlxPAhLRROFTf70Bs+h99xjrYRn/EM/H900b3WZ+63c
	 qr/P1Pkbtsf34EsivGn9+I5cCqJYoTxFM+yS0pLKUTM6gkOrjzMhJ/AGsefv8Ikl7Opjg
	 hwmvWQy6B1Gem5NjaJpr6lI5K4b20ckP+1ckP2Ss0siEELAj1PSfno8hcX6IBdmWA7JbN
	 X6EIUiMdH1x4NeHCbmo5wPs/tOsSRTWjcQFkUM3OVbN8FefbYRntphCqOZxrTaAnOUd3X
	 04gUfVF+Db6pk5LMq2fZzIF+oqDYux1dnJOkBZVRbLG0tPGvYXjlGmtP12niYCEQlSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GzD45p78gNzTa5aIk9ID2PyH1503C4udwMa1Ck4JnCw=;
	b=r8iuQe24XNOfZxjJV5EmCE/nHKnacUQObMtmwquWcizvUFF+Ogjh9qjmYzqBHSVnCPoY
	 C8f5wHYfNjkgCBSooN/6G08YBfVg/Gn1eHj4+Lf/WCkgIU0iAhS4ZQv3oGRk5hjrYBDYO
	 qCXhWqaDGHwmwYP2ItW0sgXN84kL2rAj6d+m4HGfVLJEwETX2HAf7cQKOpGcWLCVdRFtY
	 wRSo1UFjel9sNqdA0x6jCw5t0FKeftx7slMxl5KZdPzmL3MVECPt58ovQDFq0LaPda2dc
	 9p/VwKJtwebEPwpaOIZlz11coEQuZBKAIvB/FvpVgnOLSKWpU35bZPYGo5fToAf22NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phbBjwmz;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB8606B97B
	for <linux-rtc@vger.kernel.org>; Fri, 30 Oct 2026 10:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BB8606B97B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phbBjwmz
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so909796eec.1
        for <linux-rtc@vger.kernel.org>; Fri, 30 Oct 2026 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357452; x=1793962252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzD45p78gNzTa5aIk9ID2PyH1503C4udwMa1Ck4JnCw=;
        b=phbBjwmzJ1KSYKgBFMuNBKYOO1MnWiVOZvjQiJqVyeAzTJCdH1X7VJJq4RzLvz0Nl6
         OvR72MGGpaGKA5eke42lp1VvaUpC3NBC10M1sAOG7MeVeGhSuuNgllFkjOFFypkPVUJW
         hXWpq02071rYk9fCyh0m2B9U3FxMM4xFNbylHekGY2O58gNdtz6R/VdjulTXlCAKW4YC
         WkB6DfFTvyV+f5p4V3y7APBcedGTlNLHm9LYBhop68lyN/tUIhQ19xrWWm6akLELCS9O
         Yu1sIzNxvuQWOCQmstwqRykXiac0yPNdWVk/5OZC6bbOWdFYNHzcxnze5668oKjzwTTX
         ZMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357452; x=1793962252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzD45p78gNzTa5aIk9ID2PyH1503C4udwMa1Ck4JnCw=;
        b=dpoFrq9Qie/RisR7sWHKhvgi1qwcShRMfzjVXsq/INftQBwXbexD+xC2yvlN4qgutx
         8dT3Mlhl0hB4QJEGIlvBU/MOXpoMoAdnvGcl3w40PccnMDbQifCKPKeRztE8CbckYjFO
         OXSURN+NBGn4jRdehzetSOgEVPk7k4KvCB+krpmiDsK7FFRUJ3BEsZ5pGo1ig0kLaEdL
         2esSKNGCG7X83UObuZkv9PQ+FT6ADOrNi3AeqqgrhlvSeJhZs73RnLKiRneAT9s5s5Cb
         rSj41LIAnLkjvxwxqi4IQ+nmgGpc1AbhfpX1hjXz2LSCN5IBThEjLWggavGE3swVlKMx
         49ZQ==
X-Gm-Message-State: AFq9FYIHF9OdrbG7O70DqR5eDB9sC2d8msRh2u4lY0g/aMFnooVnPCZ0
	55Dv6uSJamN1z1M9tuX7mZFZkxUXjQxZD9/FnZxniTZNWtxH6/SkKFiP
X-Gm-Gg: AYBFou30iEd75f1w5NijuguzCmuwFCGbBMQlYfyFQ50n/E944+eNPzKr7yULDFEsV6+
	/yaZ1R/c45mUzPt2QJsuF/27UcpL0k3PyoD8Bqq2ltpceGBuqU6r4CZy4pMZWgzz/BFcS6aTpFu
	FA8qI17hEb9K/ZuDLRglNagdGEhnA3IUeqkxMqQO0JDPthIA5uPD1e18LkdPYrZFoX/SJsvjbHv
	VJVG7a5+mJq9Nut3Z4z6CKUcyQheuElvCBvZDbHs5FxOk6dmnb3gOwb+PVXk4gyi9bBy2SzHQcl
	+3tpIGdizCW2oo+M4NSgJuAQeZqMoxdxmdHpvKaHQ3lKMF6cufykFhifezn2C1DP5JbNV+BpjPZ
	Q2fQiu97tplg7Isjsigqgrn0uh9VRMY/jLKtxRqTnUkJtvDJ+swP+2gixI0GcACIgCwfTXeaexg
	w6Xq3m1jDYBlY4zXvexQD0/oBpn7fnj/UZDgs3u9PwhlImDylLTusDcVWlpbUoXwKTVKjqATxPG
	EV8ozNw80JZDvXdD5IVlOmECpnn/VDQLX+mz8vxc0rHdNbmhcmWeng2gh18qZ0pKBXDBV84flMV
	u61fY/mlEvwoTY1PKqBAzys/QuC7ghdnrkGerQHcmUadjhtsbFVNlQ==
X-Received: by 2002:a05:693c:639a:20b0:359:1b05:ed30 with SMTP id 5a478bee46e88-36a42203bc1mr3128900eec.4.1793357452078;
        Fri, 30 Oct 2026 03:50:52 -0700 (PDT)
Received: from LAPTOP-LJ15R92N.localdomain ([49.43.7.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm6547838eec.19.2026.10.30.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:50:51 -0700 (PDT)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] rtc: rv3029: use sysfs_emit() instead of sprintf()
Date: Fri, 30 Oct 2026 10:51:18 +0000
Message-ID: <20261030105118.426-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Use sysfs_emit() instead of sprintf() in sysfs show callbacks
(rv3029_hwmon_show_temp and rv3029_hwmon_show_update_interval) to
comply with the recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/rtc/rtc-rv3029c2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index c348b31928e9..33b73bbcaf52 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -601,7 +601,7 @@ static ssize_t rv3029_hwmon_show_temp(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", temp_mC);
+	return sysfs_emit(buf, "%d\n", temp_mC);
 }
 
 static ssize_t rv3029_hwmon_set_update_interval(struct device *dev,
@@ -654,7 +654,7 @@ static ssize_t rv3029_hwmon_show_update_interval(struct device *dev,
 		interval_ms = 0;
 	}
 
-	return sprintf(buf, "%d\n", interval_ms);
+	return sysfs_emit(buf, "%d\n", interval_ms);
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, rv3029_hwmon_show_temp,
-- 
2.56.0.windows.4

