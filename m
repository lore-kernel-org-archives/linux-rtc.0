Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE155A58;
	Wed, 15 May 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786936; cv=none; b=gvANftbbzZKOQ/EXLNIL5RBwmRGgUNYoTjGlyZoJjC6Q8jFgEOLtR64EG1x55hPMaK/cfPnY3k8TjB2kbBTpr3E08bfRtM5HxnmWgIkOC699Nx5T7rsfdw84xQbJSulDP5ZHcahqHqL4KwwGpKPU2LS7Ldk+gfUdVvrTv5u6UmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786936; c=relaxed/simple;
	bh=aqVu0Fk5ucZjX2jEY2fBASqV1jYe3DXOB6cbYHZpBd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHZgJzNGYnlSAY7Fkq2x1SMkQuKnlugdG7+jYuX7wam8bpn5JnMAHAcOI+ePCuY2EbmIbiyNm9G+9h3UPG40nzoM/4WzgFgmE1PMFg+xXb0XUjm/jYrU7q+QbZdNhDaxKX7F6/W5bN70gbmwfjluSalTCZWReahbkINbjsDd3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jRWQ+wwj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jRWQ+wwj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8842D60009;
	Wed, 15 May 2024 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715786926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c6VFlomQrU9hFBkKEGn1fs8VbVztNHUvkyirQDIeZus=;
	b=jRWQ+wwjG2Da3V9qgahVMkjq64KyfBXlrngDvS2aMMHBMnSzGXVqqTCwLk0yi+4iXlY6FO
	eVhgvcNeXq9Nu4vlCZ1VmMfVcs3c0w7yIlE3NeLxO/9j5oOS+U4Aoy+dycg+1/jwXaoxDW
	42vjNmsZ5XM+1qVeGchUNpjTBNy7Oxfle1pUr6yV0CgLnAguI+5kbqy8tHjMNrnaq8P9Mf
	XF+w1SUQvepgXaRGw0DzXuTTWQ38/aPONmEF1bo3EpT04tB6sXBOID9eApv/TjaH5m8uX6
	TbUh3uxUeHVBZC9n4cfDwJmOSfA1Om/+cf25E3pJAD+KayojSqqRhNDPB4yNYA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-rtc@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 0/1] rtc: tps6594: Add power management support
Date: Wed, 15 May 2024 17:28:26 +0200
Message-ID: <20240515152827.80185-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

Changes in v2:
 - use DEFINE_SIMPLE_DEV_PM_OPS instead of deprecated SIMPLE_DEV_PM_OPS
   (This fixes the defined but unsed warning when CONFIG_PM is unset)

Richard Genoud (1):
  rtc: tps6594: Add power management support

 drivers/rtc/rtc-tps6594.c   | 46 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tps6594.h |  1 +
 2 files changed, 47 insertions(+)

