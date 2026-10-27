Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138764;
	b=h1AOk7PUtQRRcfBbChKJb0NGm3RHbR7D7xK2YwA4pWWR7Oc/j4ovzxLQCSYiuwI6ucE5
	 ZoUD8aIMUXG6yON9i7TVOWBFeI1zlwWkedJ8Krg5cdguUV6UwlTHlORYi5ueO6MdYwBld
	 fuX3c65FZlT6lJMnoIcvf8hitZvWd2x6jrdJfOI054UN68SUcR90PXKQNBHHJT9kx4hiD
	 IejIy9F3wyvCL6LhecvhpRKgLMY7I8vJ3x7R5LQ08aM8pUqCmUFiKMHWNbSrCgFncjjBZ
	 jCybTM6CoYBjUBFGA9bcZvOwajPeh+/35twLI8m0p4XFI7RoG6T3ZkFgghFfPifEfGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138764;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VcOU/gpgM6kIJw1eQBIqbhqSgLpW/j/nJl7TkAuwxbU=;
	b=QSBnvFBX7fGLsMaeqKn7YD/lY2zNbVwVI9HM23HLAosd6CC4qBN0voy4ihgGXl70yKxe
	 7hdxqjSd62H06uO0Lbl+OAiU2Yg52S7qHMki+cl3942o8GOi50w23uWVU0HybFoA4DxOc
	 SMWEGWndqlV5lL4BtfzlVwG7LKcyZcPnKiKVIRx/UwrglDeX1ZDFLfVe4xdqGZ/CgE9La
	 QYKpynejg1xN/3PaSAsbra4J713cG0M8tq8D5XpIasV3Fp6xTPjZqaDDnEWZMdTRiWMP5
	 ARjfJJsN4lKyoDh4g0pCdiHeRoFK9if6Pc85Xj0MttRvb3wd3CTKHNNUpCJ1vSfoCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=knJ6WRK9;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B92606A31D;
	Tue, 27 Oct 2026 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B92606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=knJ6WRK9
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 98D3720B7166; Tue, 27 Oct 2026 15:05:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98D3720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793138752;
	bh=VcOU/gpgM6kIJw1eQBIqbhqSgLpW/j/nJl7TkAuwxbU=;
	h=From:To:Cc:Subject:Date:From;
	b=knJ6WRK9SS77MPrj3vvTmv8nWVJmeWD7iBHvBlfs3+TwQ11mm4ZCDOdzGHYeGdYvg
	 fhJUz8rUObWNjWQU3O7tBoKYaBNvKokA47OHrW8TAx7hotlSnYP9MRmeNQhRz0VVQj
	 57gAKyoLRxfjWEIUKplnE9ZeI+aCdsNUFeNCzQjY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH v4 0/2] rtc: efi: defer to the ACPI TAD if it can drive the RTC
Date: Tue, 27 Oct 2026 18:05:34 -0400
Message-ID: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

On Microsoft C2141 and C4143 systems, the EFI GetTime() runtime service
faults when called by rtc-efi, which causes all EFI runtime services to
be disabled, even though the RTC can be driven via the ACPI Time and
Alarm Device (TAD) instead, which acpi-tad registers an RTC class device
for since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
interface").

As suggested by Ard, add acpi_has_rtc() to the TAD driver (patch 1),
and make rtc-efi decline to probe if it returns true (patch 2).

v2:
- Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
  acpi-tad (which allows us to simplify it quite a bit) and declare it
  in linux/acpi.h. (Ard)
- Add acpi_disabled check. (Ard)
- Make rtc-efi decline to probe instead of not registering the device in
  efisubsys_init(). (Ard)
- Make RTC_DRV_EFI depend on !ACPI || ACPI_TAD. (Ard)
v3:
- Make RTC_DRV_EFI depend on ACPI_TAD || !ACPI_TAD. (Sashiko)
v4:
- Move acpi-tad code to existing CONFIG_RTC_CLASS #ifdef. (Rafael)
- Add IS_ENABLED(CONFIG_RTC_CLASS) case to linux/acpi.h.

Hamza Mahfooz (2):
  ACPI: TAD: introduce acpi_has_rtc()
  rtc: efi: defer to the ACPI TAD if it can drive the RTC

 drivers/acpi/acpi_tad.c | 48 ++++++++++++++++++++++++++++++++++++-----
 drivers/rtc/Kconfig     |  5 +++++
 drivers/rtc/rtc-efi.c   |  4 ++++
 include/linux/acpi.h    |  6 ++++++
 4 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.56.0

