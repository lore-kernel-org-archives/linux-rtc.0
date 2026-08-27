Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECF35C684;
	Thu, 27 Aug 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812299; cv=none; b=QuZQJMPVi9mR5z2vD9VtNvtSr9pW7RQyPMSNZllI+6UD09sbXZzCPBtOwPqni9NNaOrxnVcu0TcT5qbxsMt7tQ9F8KeHVTmE2llsqQqHhRQ7DJD2lExAyE3CSWBUul8lrsjdztKm7K2iunrEu2ujXW1F5kv5vmqE62h9B0evSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812299; c=relaxed/simple;
	bh=jU0wmN+cyHRaZG/2BiVEi2Q+aOWoghNIaccFzWzul44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3mnD67dOgeAvhGz42Bco2AHYO2D5C/krZ7OHpqv0oE3kj8IGIMjIfMJ+4YtjHY+ApfXm50KJBeprDqRJgpuMPTkZ+P7sEeGtYbcbisPD3LKrQgPXfKbrU0ZBybH4ygoYudYWLj7XUqFfLrw7zL2Yz+24Ezdx92ovuFsCho3mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz20t1787812230t591c1c45
X-QQ-Originating-IP: Zqc5Xjwkq0I5LO6JE8j/1Sdq6iru3r0BaEOLrkUubYs=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 14:30:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13255790985149150608
EX-QQ-RecipientCnt: 10
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH v1 0/3] rtc: ftrtc010: fix resource management and integer overflow
Date: Thu, 27 Aug 2026 14:30:16 +0800
Message-ID: <8C319CEAD84EF35B+20260827063019.3342085-1-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827021054.0963C1F000E9@smtp.kernel.org>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NyMcZNLslEFVN2hywhQ5lbXEjSbYI7YF3lRiDgS5tk/vdFSgrAUzoxti
	/JJb2iKwJESCksZwGcP60Y5cLda+soEjIbCr7N53WAdLYKYyB/8NDUzfQaaW4m8td9gZmVe
	tJUNuDCEIo8/f1ck+rI7yX3YHrLrslsmwQTjYofeZx7mDDZum96hIwqUkXBKdUprcGsQhBh
	aopaclyu28W/FIo/7723WXCPuWm0egTCFEvqqtnnTfD7TtX5vSC7nEQAhGYGb7K9U8KXuZJ
	HWLODf6+VebPlA28EdkgEEMSR26ULxMxooHjlEeQtuqt3Fv5N1hjfuJWxvGlWjBw7r/xNfM
	glpTDWt4lmcUL40UElgva9Orp5ByKuL4OH0Vb16nPMM0ChTQpEKOQbRS/S5tnhEZ0oq2CYc
	v2FRRTeC2MbZfueNflIprENpIzqXH0juvGmhx4yYqQFA6b5SFOmbEgvMbHw3VBTARkWCNq3
	TucOwKxEEgLv1SV4mzunb/fe6qmeE3tnHotMxwULcA20rqFAab2b2UVwEMMcSz78HbNPKYx
	YyW+TxFSqz7apKh943Ga/PFWsWjfKrL86cgufvjc8AdrqXik0kuHe0yZT53b+Sb51RwooNw
	oF18CuzxEpuDx5ezazkjjRlXMshuruJ6R9EsBWEbEFa1n1yPTOmINftaPQgsgRwVlq/nI92
	bTqJkI0y8YDkwaF22Y5csc6+h+OFs8DWsAWkOHnIAEYNYcF2nmqcNT5iyVrpOV7I1TXhhL4
	iVIfk5LdPA+Thm3NFSF3xdz0UYEa/+h5Vw3d6l2fYyAHats3maOZUBpWlUoIEZNIMeUI8ri
	79yVJH3RGm8nzyw2s+FywzbVCHhQuQ0zSzPRRNIt9eSBhvKDQQ8gfsK2KQB1FudvdIh0BMp
	0GF8YBS7yAbCAd4OsfmeV/14YexydTaDvzfdvVNGsEB4vyiJbGAw3DH9sw77QrQg9PQ7vek
	tkaQXNjkC2g1Snxqx2AP1S6jKkN7XfTjPcyp9/i1TwT7fhHlwXe2/ehDTQt+Pt8K8IYGIwS
	DiOtdIH1RseG9Ckz/QYdX7BcoXvsP6iykm4d1LUEaWK7w3ZBeZxOlqBSIjv5ZGkGXcT9+Lr
	vyJOQ9+eE5HEkFkN+lqpuI=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

This series fixes three issues in the Faraday FTRTC010 RTC driver
found by Sashiko AI static analysis:

Patch 1: Fixes a clock resource leak when devm_rtc_register_device()
fails in ftrtc010_rtc_probe().

Patch 2: Replaces manual clock management with devm APIs to fix a
use-after-disable vulnerability in ftrtc010_rtc_remove(). The RTC
device is registered via devm_rtc_register_device() but clocks are
manually disabled in .remove() before devres cleanup, creating a
window where MMIO reads on clock-gated hardware can cause a
synchronous external abort.

Patch 3: Fixes integer overflow in ftrtc010_rtc_read_time() and
ftrtc010_rtc_set_time() where u32 arithmetic wraps for dates
beyond year 2106.

All three patches are based on v7.2-rc2 and have been verified
with checkpatch.pl --strict.

Liu Dalin (3):
  rtc: ftrtc010: fix clock resource leak on probe failure
  rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
  rtc: ftrtc010: fix integer overflow in time calculation

 drivers/rtc/rtc-ftrtc010.c | 72 ++++++++++++++------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

--
2.43.0
