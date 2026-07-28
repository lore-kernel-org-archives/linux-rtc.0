Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8371DCB24
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198949; cv=none; b=Vp/OXeaF9TwDEvEE3Sfz7VziVsWgkpHG+ID+/IWvquk5d+Ipbv0gQokbU5R3TKRdMDpP3a01ornfkl4QeEold5Lz6+lOWqJA6D0VVoWJxJN6ZS7eVuO41/hcLDDP44jP4L4TDV5KBVTn38cUafdTeHXykD5/Pji0X6EzcUsex8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198949; c=relaxed/simple;
	bh=hBz9ZeKxOhPISJGL0W5w7IM+xWc2TAoufKmFjsENuNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqTPriQvKA1I29SSrN/ckbOPQR8zuL7G1dAD7xyXtEfN9wrVCV40YTI5BhA4M/3dCQRYV52NyDOz1s5CerFjI6HAEMVOe+IhzRVlG+sUWA06U6p0Rb9oAMgNwcAUeN/aDtdXGpPpx62/rV92QmaPt14TEqjDldLbyog5rNNrcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVD3Sbfj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVD3Sbfj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb973e6749so3693924a12.1
        for <linux-rtc@vger.kernel.org>; Mon, 27 Jul 2026 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785198948; x=1785803748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qzcGgrpTONy94iH27kAs6nN/EyFBYX9SZDPiFvz0v4=;
        b=qVD3SbfjbCRdnsQj4Mzf8Zo4eemvS1vUrvloPdtOUqRkodheXl5h7gZlCxj4qpo0So
         YZvhHnaNqbsdegtohuNk9jZC8PCTSlf4RpCkn2Vt/1xs7WQbxYzvBQZht6BEOwGFlppg
         WFtRc4SuGptYZHOxZO4nLAMFc7UYoddJiN/pPeYy5VaYTx+E7FpWuxKyKoEeGPUvOMQu
         XWclbFvsSBtQr02POjgx4oKcgYbxh+TwqOiM5fx8c6PXRGqhgVDTiTeI4HWUuZARJ0cT
         BLIwgaGz1qfGJ52jtz6J8QZZlzoLE1iPc8Qgg+Cg/3kB5favLiSiyVXSa3gZvwI9eyGj
         GLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198948; x=1785803748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qzcGgrpTONy94iH27kAs6nN/EyFBYX9SZDPiFvz0v4=;
        b=nAoEiDYINfRb+EAZdFFSzBQb/XFnAPuoSv799MFq81cXesvuo7wKUUXdOcc0PVm1RL
         nNn39Xs6zTRT+aas6COUkTgFUKnBIeRw+0JmDXrhofuKjUvGB1G/b24JNP/WverzOsRx
         mQnt3n5jaSpysp4NbTJgidb1lDkf3VdngHTuNKV/7LLX20AlAwQ8yMn7WU3n9UKrH9bz
         U8DyGDqAas0OloZI9ipEBcOgNAHuP+GRL6TOvrVHY/1Nb3PcMjsLV27VKR1uHMiSGRwz
         Ta1o4gLJQ/1Y7uKfAoAs8aK85cxmyWm5Ircr2M2JzsBoFcB95lATXSs9dSweDTDKRrys
         S05Q==
X-Gm-Message-State: AOJu0YzFWwX+WvIkt/7pyOMsDStqYtIw97XJnR4Vlb2irG8cObpeeF4H
	SiDmWYp1D6UYvaGyDzhxvm5AHp/79wFGS6YG2TOFqJ1yl+Ak2JyNevHKYvQeXZ22
X-Gm-Gg: AR+sD12a/wHLzX2qIOQNdwNS4KPjHTGtkWlmQtCpXdcqed4tb87kk8FQFJt5FoqO/Rl
	dp/OUC+fOod2+RU3CoWWdIdogVU/cl9yIvAKeL9/g1d7IRN2ITC3xAUDYG4lNcZs/kf6Il7QEHI
	2qLTLR27FAl1e+6hSUt3qQe2U3fDqlXnRhjx4DoCg6aZZJjPmKDggEPVAdUZCveGkhAkEpMl/7u
	dFOH8TqAzWpkaoFs78axzN2qwhZwl9L6wj5aNTPzUp5cdgB/TZtMIcqKJ7Vtrls6XQNuC5Q4YxB
	dcD3UIITi3cMZrldRC7ePiUjukC9UvnB79VtJymhX3qVbUJ68skrB4VYEHUb+uvGZEQI1PHNIzw
	JV8QUNzgdR6tp+l6tLCuTImSgiM8DiBsMHGyqfRPWnco7YiMtLewAgbb6eQA/EWq1znB0C/PCNQ
	27bkfFsL2JpFeC0pIR9PLOzz8+AXi2Z7qzhms5sjQ/ehB2nDbZECKxUJ1VmABcKN6owJ7HI+mK2
	WqvXf7YRdFZTviPkEPTGxV6b0W9L7uhbo6g16NogOHyIp+WjApQfak=
X-Received: by 2002:a05:6a21:7014:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c8ac2436bfmr237707637.21.1785198947589;
        Mon, 27 Jul 2026 17:35:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660dedfsm3927809a12.4.2026.07.27.17.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:35:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: omap: Add missing kernel-doc for @dev parameter
Date: Mon, 27 Jul 2026 17:35:45 -0700
Message-ID: <20260728003545.571399-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warning for omap_rtc_power_off_program() by adding the
missing @dev parameter description.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0f90065e352c..39dd91d1bf86 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -407,6 +407,7 @@ static struct omap_rtc *omap_rtc_power_off_rtc;
  * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
  * generates pmic_pwr_enable control, which can be used to control an external
  * PMIC.
+ * @dev: pointer to RTC device structure
  */
 int omap_rtc_power_off_program(struct device *dev)
 {
-- 
2.55.0

