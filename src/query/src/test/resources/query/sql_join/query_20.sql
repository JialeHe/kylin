--
-- Copyright (C) 2020 Kyligence Inc. All rights reserved.
--
-- http://kyligence.io
--
-- This software is the confidential and proprietary information of
-- Kyligence Inc. ("Confidential Information"). You shall not disclose
-- such Confidential Information and shall use it only in accordance
-- with the terms of the license agreement you entered into with
-- Kyligence Inc.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
SELECT sum(sum_item_count), TEST_KYLIN_FACT.SELLER_ID
FROM
(
select sum(item_count) as sum_item_count, CAL_DT, ORDER_ID, SELLER_ID
from TEST_KYLIN_FACT
group by CAL_DT, ORDER_ID, SELLER_ID
)
TEST_KYLIN_FACT LEFT JOIN TEST_ACCOUNT ON SELLER_ID = ACCOUNT_ID
INNER JOIN EDW.TEST_CAL_DT ON TEST_KYLIN_FACT.CAL_DT=TEST_CAL_DT.CAL_DT
LEFT JOIN TEST_ORDER ON TEST_ACCOUNT.ACCOUNT_ID = TEST_ORDER.BUYER_ID
AND TEST_CAL_DT.CAL_DT = TEST_ORDER.TEST_DATE_ENC
AND TEST_KYLIN_FACT.ORDER_ID = TEST_ORDER.ORDER_ID
GROUP BY TEST_KYLIN_FACT.SELLER_ID, TEST_ORDER.TEST_DATE_ENC


