Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0543B71D8;
	Thu, 27 Aug 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817861; cv=none; b=jo90KLcEKqvuS0J7UMPsBpJBEUN0EURZco67i5Txjj3ynfbeCbCDkfyD1SrckGwhb+JPHCeqALJb9uBp8frp7Wo1QPacAC94JDnO7dq1XTpXegfQf02tRTh8NTvYCgIWtDSqvofuEo9CFWKknhII19z4fftEYjF62Yd0D0W5Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817861; c=relaxed/simple;
	bh=4hoHcqjlyOAs+Q+rCTSUjMpIlCks10LeX6y2eVEoCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi8sob9FLc1pTP1IQN/tHMcqmF/G6JllP2F4yaOo9rh0pRqxeZ4JC2HVcUQPIoX02JoyBO2I2dmvgTbi5FcfFvor4hNzR1uNgPqWa+e05H++qp4B71lamK+FF2SKFtuFRWpthxuMywpC8J1ORiwizEJEL/uVA9/c7iLX7czfQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz1t1787817806t73a14df5
X-QQ-Originating-IP: EQuvAfVQvBDQc+OBqFpqyOCsJlKRNpzxMs3t9Ors+V0=
Received: from rd.. ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:03:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8051406103579778583
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
Subject: [PATCH v2 0/3] rtc: ftrtc010: fix resource management and integer overflow
Date: Thu, 27 Aug 2026 16:03:17 +0800
Message-ID: <B61B30904C7ACEEF+20260827080320.3351155-1-liudalin@kylinsec.com.cn>
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
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NEtAzFYxEdvUlw66KnVgHRLUGs39t65vDz4Yjo6NG1USV2fMvKx973IG
	VfD3eImyXPrbDJElyALKyR6fm56r1thtVhxu0nO1bKOif+SR08j/Z0YsHLcKNLcHJtXKhLB
	gCf1MbUDGijLwZg+heZr121ATzv9WnwLRKaH6OF3v2Ly2OjLcd/rDmTICzAFb8RhPAxTe0a
	lGlkJZLUCjPvczEcihsSuDR8heP3Vl2lIujTRi5S3uiQipvk8K+fXMk4rtIsNDuUfZdFqXf
	Ud6FGeEa9QsK8yzpA651uE6S07GMyoAzczkmtJ/mb8HPL9mU/0yw2Tfja4dKENjjO3lhyvm
	TeXfC2gyVgKZkfrBdmOP/7X7+vNHm8Vv7SOxGcD+ocgCBsBPBlMe2RDGxhEoChwIcLvdK9k
	HAfCZJK67ir6Ve2s0Vf1pHKzp9+CmsV3Oo+5HeNOebCu/Jc9rwLRfHEYKVl2Q8/1KQZl0Vl
	Ye2KXchI29t9PqTNAvt6vm2jbQtdXqHpZdYvHpLGPp5O/XulL1MtI7RxWyxQa4LLY+EcXa4
	49bSYLSmdClEhpdSsPFprqC5CWt+5TvyegmjrdzDXhUWM2+KQNlXmd6F5FMHon57XoQtV3c
	iow2tj5/nRGn3IzOjDcTEvjmb+DEsuf/ooPFirjjh5yHFe8kX4Vgz5W41owhKlN2A9EvDzx
	+xJpuyhr7OYfv2FcN/NcJ78e76Fmuom0GA1YMG3XKcIayVH/yDpUX40J1fIlTagQQ4Ys5A9
	FO5dwbmSI5s+UVaq87vjXERciBDzTK0b/mHYqQCg7G8U/hxNmD/CFvKth9l6utjnwtRXPNU
	EDu4H9Ia8zESFte4gGjfalv4CDBgyui6mrYUAfqwh8BMNZ9l9ek9Hj3IxHG5srqcmaagkoX
	6dq/euJEXeh7PC2rcRYOD9CEkGEQmIc0RDdlc4XejwCmtU7hjPfalvUR9/qLNMfcTdu8kVm
	GLYd2uCdOcTda+RUDsiQO82/AAPM7mU8zpUXZeJHOG4yLvdNLodexsHO2NkfcdAA6fYorEX
	z6Of+2WieF8RhTJSvpM3RKLptmfH0KY+MDPnp5XDDRy3yk85eAhv41zhNueajsbCtVXXI8I
	dypk1ByAcsuKA8k+PXtQjRPlC/XU39brwJNpP3xeCvnzJoRlBna9HFr9SL0TDItmKWXeF4N
	EbpD
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

Changes since v1:
- Added reply to Sashiko AI review comments on pre-existing issues
  (shared IRQ handler, sequential read rollover, TOCTOU race)
  explaining why they are not in scope for these patches.
- Clarified that PCLK/EXTCLK are required by the hardware and
  devicetree binding, so the old "optional" behavior was a bug.
- Patch 3 received no Sashiko AI review comments, confirming the
  integer overflow fix is correct.

Liu Dalin (3):
  rtc: ftrtc010: fix clock resource leak on probe failure
  rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
  rtc: ftrtc010: fix integer overflow in time calculation

 drivers/rtc/rtc-ftrtc010.c | 72 ++++++++++++++------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

--
2.43.0
