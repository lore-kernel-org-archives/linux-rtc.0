Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194824E7802;
	Tue, 29 Sep 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719212; cv=none; b=JV2PnVT3JlR2xSQzUJ1Kzp/I4oWJH7HWl7zYECz6iqWJVZ6BMYsvjBzUWIJwzoxcEgzR35qdBIury4e2TQXWSS1fDep7MMJNMnoobz0dEUQN7LjbqPFLN1kec9VBXsM8TvKlrHWAPXjd27Ud/FiItUYAFiidSY0ZZJP1ulYjJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719212; c=relaxed/simple;
	bh=RfvP/Rcc7bthj/POM/GyXTM7UX7zeEg2qL2xnbY8BTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=psQ0pBUJLafh4PvYHK2VhT5AKasm37rvgeMJWPE6BS+MT3nkDflu/RajN3XLrRLuaxKWmpO7PwBmZigpYbieMk+Jq735TdKVpNgRG7wLD3selWoa48n0QQ9yyp71YxmjEi/rLW1U/ixvvtK/kttZ2s7D8BnD+4uDCYJfTSUz3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BMgwmDIe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BMgwmDIe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 419CA4E410B4;
	Tue, 29 Sep 2026 22:00:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15414601BD;
	Tue, 29 Sep 2026 22:00:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BE17103295D5;
	Wed, 30 Sep 2026 00:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790719202; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=BpAtl+04mI7CLiVqd2KF2FbkC8J/N7vViwCsafcTwMA=;
	b=BMgwmDIe/IUtv+ARhNjUyC89eM+zaNanhw27JTyW+b8jHosBJ89/lI/4ZBDxbdD/+/v/Ps
	hEoHE6LRAU9MVerz3pXKC3nu2Eqkci1M+IlCzdCAuDiitUzQ17IgF8LyP/SSZRj5TlsZnD
	Nhdh+p55LuqOYavfl6ge3X4r2n6NtbdXAaMFj/E/cuXV2PP6oIbkd13+Dz+xIrqtoeMFo+
	jAZ8RaxjfR050MiZ+OL0Kd2ZAhnxwyEZ0ocboxL5xhOXGfYhU9//grxkazLWN2jUU14Ir4
	NVXyrUJHQu1XmNfSwvAfKmzzGOElXucesvwv3f4cHF9SqUalmr4TwSXQr1u3eg==
Date: Wed, 30 Sep 2026 00:00:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 7.3
Message-ID: <2026092922000025ba1a22@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello Linus,

Here is a collection of fixes for 7.3, mostly small issues found using
AI. The efi change is to avoid a regression on some platforms.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3-fixes

for you to fetch changes up to 055ef5ce9f67a6a3a1363fa663007f8196cc0fb8:

  rtc: spear: initialize IRQ state before requesting alarm IRQ (2026-09-21 22:46:42 +0200)

----------------------------------------------------------------
RTC fixes for 7.3

Subsystem:
 - fix a possible information leak

Drivers:
 - efi: restore alarm support with runtime capability probe

----------------------------------------------------------------
Aamir Ahmed (2):
      rtc: ac100: Assign .num before accessing .hws
      rtc: ac100: Fix clock provider use-after-free on probe failure

Johnny.Fan (1):
      rtc: efi: restore alarm support with runtime capability probe

Liu Dalin (1):
      rtc: dev: zero-initialize struct rtc_wkalrm to prevent information leak

Manush Prajwal (1):
      rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

Runyu Xiao (1):
      rtc: spear: initialize IRQ state before requesting alarm IRQ

 drivers/rtc/dev.c       |  2 +-
 drivers/rtc/rtc-ac100.c | 39 ++++++------------------
 drivers/rtc/rtc-efi.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/rtc/rtc-mpfs.c  |  6 +++-
 drivers/rtc/rtc-spear.c | 11 +++----
 5 files changed, 99 insertions(+), 39 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
