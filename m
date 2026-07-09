Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C71D6195;
	Thu,  9 Jul 2026 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635923; cv=none; b=ljaHh/j2AzTAB9MLYsASVhYQdKxHMflGwwXLTHa3Rd/Emmcp+0RVd8RIyLbNT5iYWjYkgPDZYwHgIcSx21dfnDfSHeFRywTyHF0Jg4Ga5GPTdrTYLwupg5Xsp/OUevgpV3+JOjQ8Ct6LH7lNc809PAgQQhU8r2K/RJw/qm8QJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635923; c=relaxed/simple;
	bh=z9W7j5flQCqmTqsNEYyuQfjO5wH86VqpA1HqUq3Kacc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0OHMbzc9qsuzXJJYltAhuBod4HbhAtqAVErKslT8iBq1GyD83QP8w3TWqyGm14TjfE+UvhnVPvjEakLGUzocdv/DEoRu4YhPKaC4cL+puFGRClilhYVzWO9PxOuvdjF65ck/QdRU3zV7BMM2tUJimGFHmyU85v81P0eS6BRP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjGrZuay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjGrZuay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B861F000E9;
	Thu,  9 Jul 2026 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783635922;
	bh=z9W7j5flQCqmTqsNEYyuQfjO5wH86VqpA1HqUq3Kacc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjGrZuayIWMCSvkLl9HKCehgbY+nkv+LDTltNwHmzVpiQjepGcNVl/hQcRVRDINSj
	 hDxdJZzTlUj+iM/3dgJm2ZyCQ+TLPRyCKWW/9QJOfDBKNt/OuEqf7nuhRBs7If8wog
	 HDHqxd6hLSBQnaxPfu2bhR0/77OesXvtzdL/SzHqar07Zr5zTiI0h4zbws7pjDKSlU
	 drj0AxL4aClYiXL64YJYeJYzpEJpeJm6nz74kAIZsWywu9eZ5IEet7yg4tLGGt6HRu
	 1dqMimbp05oAkWBbvVJfsAzeBck0q8I3IwgZ0Eci1AS/xmQVujqC2ufV4CuO2FDo0R
	 8jRtV/lES1TLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dt-bindings: rtc: Convert rtc-cmos binding to YAML
Reply-To: sashiko-reviews@lists.linux.dev
To: "Teja Sai Charan B" <tejaasaye@gmail.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260709221944.159244-1-tejaasaye@gmail.com>
References: <20260709221944.159244-1-tejaasaye@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:25:21 +0000
Message-Id: <20260709222521.92B861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Teja Sai Charan Bellamkonda <tejaasaye@gmail.com>
>=20
> Convert the rtc-cmos devicetree bindings to dt schema.
>=20
> The original text binding documents only the motorola,mc146818
> compatible. Existing in-tree Devicetree sources also use the
> intel,ce4100-rtc compatible together with the motorola,mc146818
> fallback, but this was not documented. Document the Intel variant in the
> schema so that these existing configurations are accepted during schema
> validation.
>=20
> Signed-off-by: Teja Sai Charan Bellamkonda <tejaasaye@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709221944.1592=
44-1-tejaasaye@gmail.com?part=3D1

