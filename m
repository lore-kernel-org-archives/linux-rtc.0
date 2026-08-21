Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DE32FA2E
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342888; cv=none; b=Ese6so3ulZFKYJ1d+Vw+o6n4zbtlpJtUCXFYRWVOFgTutDJMjGPtcAG1b0+BaQmOi0rmDNGJPDRZ8yWrtraMwVY8aRY01R7u6hfh7pFWauC3mw7IhTWaZon4j7OjLLpbL1c4MqWWpuZ0EYmKUzGzZGhIXsv6xoXWKVuQ+YJscbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342888; c=relaxed/simple;
	bh=4Pb++A0/NowUx5GPk0+P/PbBvfiebTAWIS3tF0QD2y8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JtZgTnfKKwf7e60wF4PBXflbGHGgtVif0GZnJBExn4N8id4kxSiZ3wkKYSuzbNtMG1lJylBYyOT3jeKrqIuIbKKucBKkQCB3UmOMaUyDruDK0kw7eU5kJ5l/QL4olGFbw7qtaPpX8FdnILi037YzSt3DXBd2u5phheBCeG3u5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FuDHTfLC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FuDHTfLC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 371561A178F
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:08:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB04F604AA
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E27511C77601
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 22:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787342879; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=zhgShD/a+BTpggtFZnDgiKrz3gsfGcl9gJqv96l4DLA=;
	b=FuDHTfLCL4ZoydfLZkpNexk8VsUnsBiFVKownHa43bHMq/dS/mohWtBsnDxib2wqLud2t7
	Yl77kOSdrjEGSRWzYmUJBPl5RzYf+52BXEUbYSP64hXcVQ15q1mPj4+60egM0IKV44+Khi
	z5tU8qSF+9Pgb/t0aaaqEBkvNQ5zRDdg3sMLSuy0STx7inWYPWRXY3tdKIea2liMigdTkf
	LH+nKMGu1UlXKX0s4aROr5WdGlgVwAA8aVMGEawVtdPP8aQAvBrOtBouHcq4WLGp4+zqsj
	9cOKz4G5DTZKuMoGWxPKEkfoVVqDmxt52litu8SM8tOnyhZ2ySwjFR6Q7sDKwA==
Date: Fri, 21 Aug 2026 22:07:58 +0200
From: alexandre.belloni@bootlin.com
To: linux-rtc@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update rtc subsystem patchwork location
Message-ID: <202608212007582a463833@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.55.0
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RTC subsystem is migrating it patchwork to kernel.org.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..e187e54477cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22685,7 +22685,7 @@ REAL TIME CLOCK (RTC) SUBSYSTEM
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
+Q:	https://patchwork.kernel.org/project/linux-rtc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 F:	Documentation/admin-guide/rtc.rst
 F:	Documentation/devicetree/bindings/rtc/
-- 
2.55.0

