Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656752;
	b=s41IDFnTsQy4829AfEjd1w/w4lVQRYNYfd+X64NyCAzVoqHB0XGJ+Cxe9habJq2KKWwK
	 oYLDMtxBtIRwk18YYv30aWfw+iDfRcs8B0Z7P8jMum7pmbYHB/bFGo9DLg/iSUnOUG03I
	 +ykM2Fm2Ppxhb6FhRZl3QvddB7djuvlo8UFYgbgJ5RqC6rHosALGnZ/UOHQIxOEy771a5
	 5bEnFVHfrcLdMF8jG87mebLSepX7JWEF7cxBZ+kmSwz9pP4CjKiggK4PI6/YEPVfZW0SF
	 4e0OE0NtAtxDtv1ndV4YMOPDYnH/aBiB4/m5P3cnxUEFzfVT3GFIAJmVUtZdQQltBxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aVlYtta/KrcT5WK6Gc3rn580QQmS4HTBK4d5W9mNTEw=;
	b=Gz3cdVwsfD9/T7U5kXmU6MEcpCDtNUvbUayNF9oTOB1Mv2/4rd7dAUFqTtyL26MQF9eG
	 JxC+TSYTb9NxqGtG/ZxPEKdi4FS+68HQkaQkPdW8C8B1eyOpxDJZKgpr3m/+advebTX5c
	 y+stES6sc2QyI3wXfU0e5KWUn8t04DLtM2sfc54L1y/UKO9wXKxZ5PrmWaFUJ/MwzaMjT
	 piDn0PQicuZgsnHXoUNKyBXGi8ebvM1yJPGft7ai6ThStbyYHqC2MKod7lUnnDgTkdcH0
	 jDiECCn8BL6U96YP7+y3jlNsa7dSHvq1kHMIF5jVR8xBUdM+hQoWMr9r3HJb6eKbJHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Um7uTgPk;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF1606A319
	for <linux-rtc@vger.kernel.org>; Thu, 22 Oct 2026 08:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFF1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Um7uTgPk
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so2162017eec.0
        for <linux-rtc@vger.kernel.org>; Thu, 22 Oct 2026 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792656751; x=1793261551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVlYtta/KrcT5WK6Gc3rn580QQmS4HTBK4d5W9mNTEw=;
        b=Um7uTgPkC7TJMHDc0gTllt6RE9mQT8awZdRBqtzmuOpjF/nkcklZX/4UhUuCjAYeCw
         rE+eowxyhLvBhxyShGCHxzCHWQawiM5BdwrcZIf1eSBDp2gzNxFkrQSM3Vxo0/EoqrX4
         WGwUchfqdeGtEX0g00668TFGVex3/F6nqU6BPyVQAN1PB7W1ApQBvTpcjU3hbIAgcLSy
         NqvPqRYBCsHljlZB861XLkCVoaFXa7w1MUFmKywAGGV4mHpGP+mRVnygXoFsACjQ+mVG
         +E9Avqd0Xk5O3goRF6uufFQ6bkR3u2H1tSkiiYUMGccH7I5pjblaTJUVpICdA9qucPO/
         4MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792656751; x=1793261551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVlYtta/KrcT5WK6Gc3rn580QQmS4HTBK4d5W9mNTEw=;
        b=FZLj06apnSDmAane5zFA8Qn97evAy3BLt4T76o2OBDNWviObS26e2OfqPsLUAT21Jy
         SJfjBpnjBGcEf/+r/2CByDUGvpXy6kyJO4SDWZRwGBJxaVTpmPCrCK20bIPvOtc4TkWO
         M/ozx1FR6DSslQLE3nigXfzfi7/WBynPQ/5KlU+6JY+TdplxJ1oasphr7LDC/PQtFq3u
         cV4fP222FF+h8oYkXl21aQBOyliblXzAkqji/xqxSaqkbc7Miyk1E0a/rMnao88IxPqL
         pcEMsFVEECgP8DZzsVShGuiKHjRt//SyGFXUSdAB8eTPTEOThQZvtM7+wRmwHTSavSQP
         /awQ==
X-Gm-Message-State: AFq9FYK5I5eV502ri8aRJQCeJGa2H8DUeh380/GAasSLm+ptQvq0PspS
	sKv3zYV0mbXCIfFzP8RPbxlFoH2mSqg6hRgg9NzjgFCP1CkKA+/BIkPnvZ6Ez2wD
X-Gm-Gg: AYBFou1dGA3hkp7XT1epcRONWSxtW0YqWjPle3F/Iq0HTJAOGCJwOvxcMQuCDizvsI/
	trht7KndB0pMxiiynOoUOxxPtzzGBzCcg1kmbQt95YAFnVSPdUoPn6yy8EFjUMDRXYASaK1fEy5
	Zmb+1cyDyfpC0Qpa+s8qf/Adl1PwlZwYpOADKgmnFRI9OteX3SyUkTpw7QG93cPy5KozS+Xbrvc
	tLg9QdBOVv03LZBkDhn012HAw7uUzLcW/4l3YjigT78vVkuHo7foqxhrKYufTpXeFpmwD6PTPEM
	sHIsCRd891HKbmVAMWug7/cBs/j8TR31dk64tAPJRR91GIdMyIz0X4tcBFhALjijM8FqKEgqsbt
	quJR2N7wnFb7nVUx4JLYx3wWKp1MCVNF4ZnYwRc3/kYMKgRQEgNuzkTJL0K0IEkjum2/17XElMl
	Q0PFGiRge2tb0v2RvfJlYKFU3NEgHaAaffDOzTTHLnY0/Djnt3SM5NiriJdWFdgHR0Mek/ttawe
	jRJUBoViJPm4jJNW9VTP3Ua/LzWz9ccdDoJRrVyWCl6NpKgRpAmrjXFzd6ZItyhc++Y/RxKUJjG
	cGkcW0MFgwc=
X-Received: by 2002:a05:7301:8615:b0:359:8492:20ff with SMTP id 5a478bee46e88-3674c43a7a8mr5901963eec.12.1792656750578;
        Thu, 22 Oct 2026 01:12:30 -0700 (PDT)
Received: from LAPTOP-LJ15R92N.localdomain ([152.58.25.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367f52ce166sm10790141eec.29.2026.10.22.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:12:30 -0700 (PDT)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] rtc: rv3028: use sysfs_emit() instead of sprintf()
Date: Thu, 22 Oct 2026 08:12:42 +0000
Message-ID: <20261022081242.421-1-akshatrawat095@gmail.com>
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
(timestamp0_show and timestamp0_count_show) to conform to the
recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/rtc/rtc-rv3028.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d25e33d08..b3a5b1ef3 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -147,8 +147,8 @@ static ssize_t timestamp0_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%llu\n",
-		       (unsigned long long)rtc_tm_to_time64(&tm));
+	return sysfs_emit(buf, "%llu\n",
+			  (unsigned long long)rtc_tm_to_time64(&tm));
 };
 
 static DEVICE_ATTR_RW(timestamp0);
@@ -164,7 +164,7 @@ static ssize_t timestamp0_count_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", count);
+	return sysfs_emit(buf, "%u\n", count);
 };
 
 static DEVICE_ATTR_RO(timestamp0_count);
-- 
2.56.0.windows.2

