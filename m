Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9F3E4C6C;
	Tue, 31 Mar 2026 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985962; cv=none; b=DO2TOc5KMaYpHNv19ppY4P3RYxOZIlKKIRc/QZaYANHQkhStOS7mmuVZubteRdjDBGw6hwwjXPRSkYYuHFi33s6ZHpHiQ9adY12w4MwK8WFejwlj0z/CcJsYuRhg8ARtQ7qa8hyToe1aMbydWBem2oGPEUclHAqBOOcmgaez3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985962; c=relaxed/simple;
	bh=yrEbikV1Zhso82smuvpcjpHXXZ8EwuaQJr3nYuWt/w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tb0v1KCkE8FowiFzUIYppqkMp5NynacgCYon47SLE1QOpKi9iJ9rhShdux9FxaUvdudNE2AdSRFQR7I4pHsekASQVPrVanx9r89wFzEO1aAsw58CtZFA/PpzxIAt0dqEjEY9KodbpBuI9mcG6DZ86kz6NnIxAwBqheOuBETxXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G751NOUO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G751NOUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31656C19423;
	Tue, 31 Mar 2026 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774985962;
	bh=yrEbikV1Zhso82smuvpcjpHXXZ8EwuaQJr3nYuWt/w8=;
	h=From:To:Cc:Subject:Date:From;
	b=G751NOUOo2r0WpTFp+mxC8KT8F+NhrfIjtLr72bJ+rxyOYImbt8pl7M62maQH5g0y
	 NP2WzecYfz2ZF9dX+kh3K7J4Wl2qV9e1fRPB2/LYlnP130z3sLJN0fSh70cFGwZCMJ
	 6jCGZcHs+IovqGdjc6WND8b65/PA8oElLns83MkBO79OrVuYGwsEpqVNlgsGkdP3oE
	 1jlF7zZZ6G5bA7D19STvlTbF2t/EdhZ8OP6BwX4mZLLxZobjUiKFVrKOCnCfBiCZLB
	 aUIIY1hFXSMRnN00nfSDlfQBt865IK0ED7vzU+jTaBdTfkQYiixVT8HCOlXtLXQIHP
	 SwTO6qJ0IiDQw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 0/4] ACPI: TAD: Add alarm support to RTC class device interface
Date: Tue, 31 Mar 2026 21:23:26 +0200
Message-ID: <2366642.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series adds alarm support via the RTC class device interface
of the ACPI time and alarm device (TAD) driver.

The code is first rearranged to facilitate re-use (patches [1-3/4]
and then the RTC class interface of the driver is extended to
support alarm (patch [4/4]).

Thanks!



