Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAC32861F;
	Wed, 22 Apr 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871675; cv=none; b=C7pyXn3qhlsr78vIJmIccKojLT1UwvczUcSRaK+7fhuwNgp806JlXKYi/x4QQAxF6zoDHNgWqYX9JfC9/cOOoygDBFyIE7PHmAaKAZGBEE/Qn+jOrvOICG43zcGpDaUvQULAw37iisFjfo3lNBZf3jQfFBA3/fbx46+nlyg8TSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871675; c=relaxed/simple;
	bh=NVmot+vxgpRTiaQ+60GFGpNH7UVQX7tim9k5fsbuotQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8p0449P9gQiM7lFsDVJELovgKXNJX/SWY/MrcjquTwR5nhlS3FzpAV3RC4LhmgyLqvuWf11hP/tBRdD2AgcsaP4CnKIt0Qmr9WJpNiJ3D7tsx9wKXW/jCQPT390Z6G2KGhtIIRDcOcj9wer+AgQu7gK9njTPTSHi+h8lJ2w+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMf8ryn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMf8ryn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAE2C19425;
	Wed, 22 Apr 2026 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871675;
	bh=NVmot+vxgpRTiaQ+60GFGpNH7UVQX7tim9k5fsbuotQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMf8ryn1AXF0HBAxqiYembLdz3RUC6wKWIbKGLxeoZMhgAU78i5B1ojptsVgQRF2J
	 JCmv0IjEC5tL1wfPSz6JQSKbRovP4qJDQ+qD55PQQpAekBV4RG8c0qq0jSfDLFHMXp
	 CntiBWx3ZmPQJWCcLUekTsZBGWesfecDFMjjF3yHn+s1qz1EBs4+jHtF32tCj4za4V
	 rugJQ3jmMFYF2VlBJyTJS3gdz2eYGnD7rtpEHB+ScjJpRwrvV+8RPVPR5E0Y7vpOZw
	 baJGeugJVlGDQ3p155zsczj+ITAxulDh/20Kit/FsMVCZywClmkeQBRfnAXKt/K21z
	 6xw2A6MIC4QeQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 4/4] ACPI: TAD: Fix up a comment in acpi_tad_probe()
Date: Wed, 22 Apr 2026 17:27:32 +0200
Message-ID: <8678306.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2415066.ElGaqSPkdT@rafael.j.wysocki>
References: <2415066.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix grammar in the comment preceding the pm_runtime_set_active() call in
acpi_tad_probe().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -859,8 +859,8 @@ static int acpi_tad_probe(struct platfor
 	}
 
 	/*
-	 * The platform bus type layer tells the ACPI PM domain powers up the
-	 * device, so set the runtime PM status of it to "active".
+	 * The platform bus type probe callback tells the ACPI PM domain to
+	 * power up the device, so set the runtime PM status of it to "active".
 	 */
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);



